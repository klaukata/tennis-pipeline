{% macro calculate_ratio(col_a, col_b) %}
    ROUND(({{ col_a }}::float) / NULLIF({{col_b}}, 0), 2)
{% endmacro %}