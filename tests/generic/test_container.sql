{% test fast_distinct_check(model, column_name, target_count) %}
    -- approximate distinct counts are usually within 5% of true value. Let's assume 6% to reduce false alarms
    {% set upper_bound = target_count * 1.06 %}
    {% set lower_bound = target_count * 0.94 %}

    with counts as (
        select approx_count_distinct({{ column_name }}) as apx_cnt
        from {{ model }}
    )
    select * from counts
    where apx_cnt not between {{ lower_bound }} and {{ upper_bound }}  {# increased readability - calculations moved to top #}
{% endtest %}


{% test column_not_present(model, column_name) %}
    {%- set columns = adapter.get_columns_in_relation(model) -%}
    {%- if column_name in columns|map(attribute='column') -%}
        SELECT "Column {{ column_name|string }} is present, but should not be." AS result
    {%- else -%}
        SELECT NULL as result LIMIT 0  -- Pass the test
    {%- endif -%}
{% endtest %}