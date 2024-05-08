--pokud je pk unikátní, vytvoř jej, jinak přidej sloupec

{% macro create_pk(table_name) %}

{%- call statement('inserted_values', fetch_result=true) %}  
     
                   SELECT  max(create_pk) AS PK_type from table_def
                where table_name = UPPER('{{table_name}}')
                    {%- endcall -%}

  {% set pk_type = load_result('inserted_values') %}
  {{print(pk_type)}}
   {% set pk_type_1 = pk_type['data'] %}
    {% set pk_type_2 = pk_type_1[0] %}
    {{print(pk_type_2[0])}}
    {% if pk_type_2[0] == 1 %}

                {% set query %}
                ALTER TABLE {{table_name}} ADD CONSTRAINT {{table_name}}_id PRIMARY KEY  (id)
            {% endset %}

            {% do run_query(query) %}
      
      {{print('1')}}
    {% else %}
        {% set query %}
            ALTER TABLE {{table_name}} ADD COLUMN ID INT
            {% endset %}

            {% do run_query(query) %}
            {% set query %}

            insert into {{table_name}} (id)
            SELECT  row_number() OVER (ORDER BY 1 DESC)
            from {{table_name}};
            ALTER TABLE {{table_name}} ADD CONSTRAINT {{table_name}}_id PRIMARY KEY  (id)
        {% endset %}

            {% do run_query(query) %}
        {{print('2')}}
    {% endif %}

 {% endmacro %}