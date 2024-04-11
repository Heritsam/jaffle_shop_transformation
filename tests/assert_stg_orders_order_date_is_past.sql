with orders as (
    select * from {{ ref('stg_orders') }}
)

select
    order_id,
    order_date
from orders
where order_date > current_date()