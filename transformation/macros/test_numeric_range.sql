{% test numeric_range(model, column_name, min=none, max=none) %}

    {% if min is not none and max is not none %}
        select *
        from {{ model }}
        where {{ column_name }} < {{ min }} or {{ column_name }} > {{ max }}
    
    {% elif min is not none %}
        select *
        from {{ model }}
        where {{ column_name }} < {{ min }}
    
    {% elif max is not none %}
        select *
        from {{ model }}
        where {{ column_name }} > {{ max }}
    
    {% else %}
        -- If neither min nor max is provided, return empty result
        select *
        from {{ model }}
        where false
    
    {% endif %}

{% endtest %}
