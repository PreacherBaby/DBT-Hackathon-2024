{% macro mark_columns(table_name) %}

{% set column_fill_query %}
    SELECT column_name
    FROM information_schema.columns
    WHERE table_name = '{{ table_name }}'
    AND table_schema = 'data_sample';
{% endset %}

{% set column_fill_results = run_query(column_fill_query) %}

{% for column_info in column_fill_results %}
    {% set column_name = column_info['column_name'] %}
    
    {% set fill_rate_query %}
        SELECT COUNT(*) AS total_rows,
               COUNT({{ column_name }}) AS filled_rows,
               (COUNT({{ column_name }}) * 100.0) / COUNT(*) AS fill_rate
        FROM data_sample.{{ table_name }};
    {% endset %}
    
    {% set fill_rate_results = run_query(fill_rate_query) %}
    {% set fill_rate_info = fill_rate_results[0] %}
    
    {% set fill_rate = fill_rate_info['fill_rate'] %}
    
    ALTER TABLE {{ table_name }} ADD COLUMN "{{ column_name }}_mark" INT DEFAULT 
    {% if fill_rate > 20 %}
        1;
    {% else %}
        0;
    {% endif %}
{% endfor %}

{% endmacro %}