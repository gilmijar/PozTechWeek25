with
    customers as (
        select
            customer_id
            , concat_ws("; ", last_name, first_name) as customer_name
            , year(birth_date) as birth_year
        from {{ ref("stg_customer") }}
    )

    , rental as (
        select 
            customer_id, 
            sum(rental_amount) as total_rental_amount
        from {{ ref("int_rental") }}
        group by all
    )

    select 
        customer_id
        , customer_name
        , customers.birth_year
        , total_rental_amount
        , rank() over (order by total_rental_amount desc) customer_rank
        from customers
        join rental using(customer_id)
        qualify rank() over (order by total_rental_amount desc) <= 10

