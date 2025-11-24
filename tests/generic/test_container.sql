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