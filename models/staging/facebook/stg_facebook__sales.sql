
-- Renaming products columns following project pattern
with fb_sales_columns_names_pattern as (
    select
        "FB_GUID" as guid,
        "FB_CUSTOMER_GUID" as customer_guid,
        "FB_CUSTOMER_PROFILE_URL" as customer_profile_url,
        "FB_PRODUCTS_GUIDS" as products_guids,
        "FB_PRODUCTS_QUANTITIES" as products_quantities,
        "FB_SALES_DATETIME" as datetime,
        "FB_SALES_PAYMENT_METHOD" as payment_method
    from {{ source('facebook', 'fb_sales') }}
),

-- Converting products columns data types
fb_sales_columns_data_types as (
    select
        guid::varchar(36) as guid,
        customer_guid::varchar(36) as customer_guid,
        customer_profile_url::varchar(100) as customer_profile_url,
        string_to_array(replace(replace(products_guids, ']', ''), '[', ''), ',') as products_guids,
        string_to_array(replace(replace(products_quantities, ']', ''), '[', ''), ',') as products_quantities,
        to_timestamp(datetime::varchar, 'YYYY-MM-DD HH24:MI:SS') as datetime,
        lower(payment_method::varchar(100)) as payment_method
    from fb_sales_columns_names_pattern
)

select * from fb_sales_columns_data_types
