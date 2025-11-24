-- checks that we did not multiply rows in rental by joining with payment
with
    landing_rental as (
        select count(*) cnt from {{ source('landing', 'rental') }}
    )
    , int_rental as (
        select count(*) cnt from {{ ref('int_rental') }}
    )

select 
    landing_rental.cnt as landing_cnt
    , int_rental.cnt as int_cnt
from landing_rental
cross join int_rental
where int_rental.cnt > landing_rental.cnt
