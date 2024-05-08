{% macro mark_columns(table_name,column_name) %}
 

   
    {% set fill_rate_query %}
        SELECT COUNT(*) AS total_rows,
               COUNT({{ column_name }}) AS filled_rows,
               (COUNT({{ column_name }}) * 100.0) / COUNT(*) AS fill_rate
        FROM data_sample.{{ table_name }};
    {% endset %}
   
    {% set fill_rate_results = run_query(fill_rate_query) %}
    {{print(fill_rate_results)}}
    {% set fill_rate_info = fill_rate_results[0] %}
   
    {% set fill_rate = fill_rate_info['FILL_RATE'] %}
   
    
    {% if fill_rate > 20 %}
        1;
    {% else %}
        0;
    {% endif %}
 
{% endmacro %}