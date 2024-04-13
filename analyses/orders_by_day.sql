with orders as (
    select * from {{ ref('fct_orders') }}
)

select
    order_date,
    count(order_id) as num_of_orders
from orders
group by 1
order by 2 desc