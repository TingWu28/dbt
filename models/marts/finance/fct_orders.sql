with orders as (
    select order_id, customer_id from {{ ref('stg_jaffle_shop__orders') }}
),

payments as (
    select ORDERID as order_id, sum(AMOUNT) as payment from RAW.STRIPE.PAYMENT
    group by order_id
)
,

final as (
    select orders.order_id, orders.customer_id, payments.payment
    from orders
    left join payments using (order_id)
)


select * from final