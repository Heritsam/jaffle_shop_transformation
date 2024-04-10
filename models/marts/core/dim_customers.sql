with customers as (
    select * from {{ ref('stg_customers') }}
),
orders as (
    select * from {{ ref('stg_orders') }}
),
customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as num_of_orders
    from orders
    group by 1
),
final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.num_of_orders, 0) as num_of_orders,
        sum(fct_orders.amount) as lifetime_value
    from customers
    left join customer_orders using(customer_id)
    left join {{ ref('fct_orders') }} as fct_orders using(customer_id)
    group by all
)

select * from final