{% macro calc_ratio(col_a, col_b) %}
    case
        when {{ col_b }} = 0
            then null
        else
            round(cast({{ col_a }} as numeric) / cast({{col_b}} as numeric), 2)
    end
{% endmacro %}