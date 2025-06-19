{%- macro build_key_from_columns(dbt_relation, exclude=[]) -%}

{% set cols = dbt_utils.get_filtered_columns_in_relation(dbt_relation, exclude)  %}

{{ return(dbt_utils.generate_surrogate_key(cols)) }}

{%- endmacro -%}