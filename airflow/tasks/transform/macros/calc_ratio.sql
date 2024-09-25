{% macro calc_ratio(col_a, col_b) %}
    case
        when {{ col_b }} = 0
            then null
        else
            {{col_a}}::float // {{col_b}}
    end
{% endmacro %}