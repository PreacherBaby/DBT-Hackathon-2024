{% macro table_def() %}

   SELECT table_name,column_name,data_type,CASE WHEN column_name = 'ID' THEN 1 ELSE 0 END AS "CREATE_PK"
                    , CASE WHEN data_type LIKE '%TIMESTAMP%' THEN 1 ELSE 0 END as "CREATE_TIMESTAMP_TZ"
                    FROM INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA = 'DATA_SAMPLE'
                    AND TABLE_NAME LIKE '%PIZZA_%'
                    ORDER BY table_name,ordinal_position
{% endmacro %}

