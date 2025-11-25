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
    , rental.return_date
    , rental.payment_deadline
    , rental.create_date
    , payment.payment_id
    , payment.amount as payment_amount
    , payment.payment_date
    , datediff(rental.return_date, rental.rental_date) as duration_days
    , rental.rental_rate * duration_days as rental_amount
from rental
left join payment using (rental_id)