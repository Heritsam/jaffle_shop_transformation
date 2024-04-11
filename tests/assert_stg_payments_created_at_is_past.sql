with payments as (
    select * from {{ ref('stg_payments') }}
)

select
    payment_id,
    created_at
from payments
where created_at > current_date()