{% macro calculate_ratio(col_a, col_b) %}
    ROUND(({{ col_a }}::float) / {{col_b}}, 2)
{% endmacro %}