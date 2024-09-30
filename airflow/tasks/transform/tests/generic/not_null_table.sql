{% test not_null_table(model, excl_col_list) %}
{%- if execute -%} {# if sql is being run #}
{%- set model_columns = adapter.get_columns_in_relation(model) -%}

{%- for col in model_columns if col.column|upper not in excl_col_list|upper %}
  select 
    count(*) as c
  from (
    select {{ col.column }}
    from {{ model }}
    where {{ col.column }} is null
  )
  having c > 0
  {%- if not loop.last %}
    union all
    {%- endif %}
{%- endfor -%}

{%- endif -%}
{% endtest %}