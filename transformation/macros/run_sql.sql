{% macro run_sql(sql) %}
    {% set results = run_query(sql) %}
    {% do results.print_table() %}
{% endmacro %}
