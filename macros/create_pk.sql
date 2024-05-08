--pokud je pk unikátní, vytvoř jej, jinak přidej sloupec

{% macro pk(table_name) %}

{%- call statement('inserted_values', fetch_result=true) %}  
     
                   SELECT table_name FROM information_schema.tables WHERE table_name like 'PIZZA_%' 
                   
 {%- endcall -%}

 {% endmacro %}