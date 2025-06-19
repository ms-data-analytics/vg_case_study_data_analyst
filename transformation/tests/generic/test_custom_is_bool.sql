{% test is_bool(model, column_name) %}

with validation as (

    select
        {{ column_name }} as test_field

    from {{ model }}

),

validation_errors as (

    select
        test_field

    from validation
    where (test_field) > 1

)

select *
from validation_errors

{% endtest %}


