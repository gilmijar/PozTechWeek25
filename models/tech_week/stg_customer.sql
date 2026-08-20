select
    customer_id
    , first_name
    , last_name
    , address_id
    -- the change
    , email
    , birth_date
    , create_date
    , last_update
from {{ source("landing", "customer") }}