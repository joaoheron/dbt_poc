
-- Renaming sales columns following project pattern
with sales_columns_names_pattern as (
    select
        "SALESID" as id,
        "SALESCUSTOMERID" as customer_id,
        "SALESPRODUCTID" as product_id,
        "SALESEMPLOYEEID" as employee_id,
        "SALESQUANTITY" as quantity,
        "SALESTRANSACTIONTIME" as transaction_datetime,
        "SALESPAYMENTMETHOD" as payment_method
    from {{ source('application', 'app_sales') }}
),

-- Converting sales columns data types
sales_columns_data_types as (
    select
        id::int as id,
        customer_id::int as customer_id,
        product_id::int as product_id,
        employee_id::int as employee_id,
        quantity::int as quantity,
        to_timestamp(transaction_datetime, 'YYYY-MM-DD HH24:MI:SSZ') as transaction_datetime,
        lower(payment_method::varchar(100)) as payment_method
    from sales_columns_names_pattern
)

select * from sales_columns_data_types
