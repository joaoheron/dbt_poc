with fb_sales as (
    select
        guid
        , customer_guid
        , products_guids
        , products_quantities
        , datetime
        , payment_method
    from {{ ref('stg_facebook__sales') }}
),

flatened AS (
    SELECT fb_sales.*
        , t1.value::varchar as product_guid
        , t1.index as product_index
    FROM fb_sales, table (flatten(fb_sales.products_guids)) as t1
)

select *
    , get(products_quantities, product_index)::int as product_quantity
from flatened
