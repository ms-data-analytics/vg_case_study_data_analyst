{% macro drop_table(schema_name, table_name) %}
    {% set query %}
        DROP TABLE IF EXISTS {{ schema_name }}.{{ table_name }}
    {% endset %}
    {% do run_query(query) %}
    {{ print("Dropped table " ~ schema_name ~ "." ~ table_name) }}
{% endmacro %}
