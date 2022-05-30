
-- Renaming sales columns following project pattern
with sales_columns_names_pattern as (
    select
        SalesId as id,
        SalesCustomerId as customer_id,
        SalesProductId as product_id,
        SalesEmployeeId as employee_id,
        SalesQuantity as quantity,
        SalesTransactionTime as transaction_datetime,
        SalesPaymentMethod as payment_method
    from {{ ref('app_sales') }}
),

-- Converting sales columns data types
sales_columns_data_types as (
    select
        id::int as id,
        customer_id::int as customer_id,
        product_id::int as product_id,
        employee_id::int as employee_id,
        quantity::int as quantity,
        to_timestamp(transaction_datetime, 'YYYY-MM-DD HH24:MI:SS') as transaction_datetime,
        lower(payment_method::varchar(100)) as payment_method
    from sales_columns_names_pattern
)

select * from sales_columns_data_types
