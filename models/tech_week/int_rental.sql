with
    rental as (
        select *
        from {{ source('landing', 'rental') }}
    )
    , payment as (
        select *
        from {{ source('landing', 'payment') }}
    )

select 
    rental_id
    , rental.rental_rate
    , rental.customer_id
    , rental.inventory_id
    , rental.staff_id
    , rental.rental_date
    , rental.payment_deadline
    , rental.create_date
    , payment.payment_id
    , payment.amount
    , payment.payment_date
    -- TODO: duration, payment delay
from rental
left join payment using (rental_id)