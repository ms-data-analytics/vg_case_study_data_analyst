{% macro explore_schemas() %}
    {% set query %}
        SELECT schema_name FROM information_schema.schemata
    {% endset %}
    {% set results = run_query(query) %}
    {% do results.print_table() %}
{% endmacro %}

{% macro explore_tables(schema_name) %}
    {% set query %}
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = '{{ schema_name }}'
    {% endset %}
    {% set results = run_query(query) %}
    {% do results.print_table() %}
{% endmacro %}
