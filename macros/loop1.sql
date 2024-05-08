{% macro loop1() %}
  
   {%- call statement('inserted_values', fetch_result=true) %}  
     
                   SELECT table_name FROM information_schema.tables WHERE table_name like 'PIZZA_%' 
                   AND table_schema = 'DATA_SAMPLE'
                   
 {%- endcall -%}
  
  {% set pizza_tables = load_result('inserted_values') %}
   {% set pizza_tables = pizza_tables['data'] %}
  {% for table_info in pizza_tables %}
    {% set table_name = table_info[0] %}
    {% if table_name %}
      {{ create_table(table_name) }}
    {% endif %}
  {% endfor %}
{% endmacro %}