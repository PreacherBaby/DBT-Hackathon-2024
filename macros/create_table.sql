{% macro create_table(table_name) %}
--CREATE TABLE '{{ table_name }}' AS 
{% set query %}
   CREATE OR REPLACE TABLE {{ table_name }}
   
   
    AS 
SELECT *
FROM data_sample.{{ table_name }} {{ table }};
  {% endset %}

  {% do run_query(query) %}

{{create_pk(table_name)}}

{% endmacro %}