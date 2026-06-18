with country as (
    select
        country_id
        , country
    from {{ source("landing", "country") }}
)

, city as (
    select
        city_id
        , city
        , country_id
    from {{ source("landing", "city") }}
)

, address as (
    select
        address_id
        , address || address2
        , postal_code
        , city_id
    from {{ source("landing", "address") }}
)

, customer as (
    select
        customer_id
        , first_name
        , last_name
        , email
        , birth_date
        , address_id
    from {{ source("landing", "customer") }}
)

SELECT *
from customer
join address using (address_id)
join city using (city_id)
join country using (country_id)
