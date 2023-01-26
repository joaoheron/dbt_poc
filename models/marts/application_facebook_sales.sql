with app_sales as (
    select * from {{ ref('stg_application__sales') }}
),

fb_sales as (
    select * from {{ ref('fb_sales_items') }}
),

app_sales_sk as (
    select app_sales.*
        , dim_products.application_price as unit_price
        , dim_products.application_price * app_sales.quantity as total_price
        , dim_products.application_currency as currency
        , dim_customers.sk as customer_sk
        , dim_employees.sk as employee_sk
        , dim_products.sk as product_sk
    from app_sales
        left join {{ ref('dim_customers') }} as dim_customers
        on app_sales.customer_id = dim_customers.application_id

        left join {{ ref('dim_employees') }} as dim_employees
        on app_sales.employee_id = dim_employees.application_id

        left join {{ ref('dim_products') }} as dim_products
        on app_sales.product_id = dim_products.application_id
),

fb_sales_sk as (
    select fb_sales.*
        , dim_products.facebook_price as unit_price
        , dim_products.facebook_price * fb_sales.product_quantity as total_price
        , dim_products.facebook_currency as currency
        , dim_customers.sk as customer_sk
        , NULL as employee_sk
        , dim_products.sk as product_sk
    from fb_sales
        left join {{ ref('dim_customers') }} as dim_customers
        on fb_sales.customer_guid = dim_customers.facebook_guid

        left join {{ ref('dim_products') }} as dim_products
        on fb_sales.product_guid = dim_products.facebook_guid
),

app_fb_sales as (
    select 
        app_sales.id as application_id
        , app_sales.customer_id as application_customer_id
        , app_sales.product_id as application_product_id
        , app_sales.employee_id as application_employee_id
        , app_sales.quantity as application_quantity
        , app_sales.transaction_datetime as application_transaction_datetime
        , app_sales.payment_method as application_payment_method
        , 0 as application_product_index
        , app_sales.unit_price as application_unit_price
        , app_sales.total_price as application_total_price
        , app_sales.currency as application_currency
        , app_sales.customer_sk as application_customer_sk
        , app_sales.employee_sk as application_employee_sk
        , app_sales.product_sk as application_product_sk
        , NULL as facebook_guid
        , NULL as facebook_customer_guid
        , NULL as facebook_product_guid
        , NULL as facebook_product_quantity
        , NULL as facebook_datetime
        , NULL as facebook_payment_method
        , NULL as facebook_product_index
        , NULL as facebook_unit_price
        , NULL as facebook_total_price
        , NULL as facebook_currency
        , NULL as facebook_customer_sk
        , NULL AS facebook_employee_sk
        , NULL as facebook_product_sk
        , 'app' as sales_type
    from app_sales_sk as app_sales

    union all

    select 
        NULL as application_id
        , NULL as application_customer_id
        , NULL as application_product_id
        , NULL as application_employee_id
        , NULL as application_quantity
        , NULL as application_transaction_datetime
        , NULL as application_payment_method
        , NULL as application_product_index
        , NULL as application_unit_price
        , NULL as application_total_price
        , NULL as application_currency
        , NULL as application_customer_sk
        , NULL as application_employee_sk
        , NULL as application_product_sk
        , fb_sales.guid as facebook_guid
        , fb_sales.customer_guid as facebook_customer_guid
        , fb_sales.product_guid as facebook_product_guid
        , fb_sales.product_quantity as facebook_product_quantity
        , fb_sales.datetime as facebook_datetime
        , fb_sales.payment_method as facebook_payment_method
        , fb_sales.product_index as facebook_product_index
        , fb_sales.unit_price as facebook_unit_price
        , fb_sales.total_price as facebook_total_price
        , fb_sales.currency as facebook_currency
        , fb_sales.customer_sk as facebook_customer_sk
        , NULL AS facebook_employee_sk
        , fb_sales.product_sk as facebook_product_sk
        , 'fb' as sales_type
    from fb_sales_sk as fb_sales
),

sales_common as (
    select 
        case 
            when sales_type = 'app' then application_id::varchar(36)
            else facebook_guid::varchar(36)
            end as id
        , case 
            when sales_type = 'app' then application_quantity
            else facebook_product_quantity
            end as quantity
        , case 
            when sales_type = 'app' then application_transaction_datetime
            else facebook_datetime
            end as datetime
        , case 
            when sales_type = 'app' then application_payment_method
            else facebook_payment_method
            end as payment_method
        , case 
            when sales_type = 'app' then application_product_index
            else facebook_product_index
            end as product_index
        , case 
            when sales_type = 'app' then application_unit_price
            else facebook_unit_price
            end as unit_price
        , case 
            when sales_type = 'app' then application_total_price
            else facebook_total_price
            end as total_price
        , case 
            when sales_type = 'app' then application_currency
            else facebook_currency
            end as currency
        , case
            when sales_type = 'app' then application_customer_sk
            else facebook_customer_sk
            end as customer_sk
        , case
            when sales_type = 'app' then application_employee_sk
            else facebook_employee_sk
            end as employee_sk
        , case
            when sales_type = 'app' then application_product_sk
            else facebook_product_sk
            end as product_sk
        , sales_type
    from app_fb_sales
)

select * from sales_common
