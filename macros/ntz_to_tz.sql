{% macro convert_timezone(source_tz, target_tz, source_timestamp) %}
{% if source_tz is none %}
    SELECT CONVERT_TIMEZONE({{ target_tz }}, {{ source_timestamp }}) AS converted_timestamp;
{% else %}
    SELECT CONVERT_TIMEZONE({{ target_tz }}, TO_TIMESTAMP({{ source_timestamp }}, {{ source_tz }})) AS converted_timestamp;
{% endif %}
{% endmacro %}
