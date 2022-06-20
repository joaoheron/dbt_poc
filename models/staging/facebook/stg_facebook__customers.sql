
-- Renaming customers columns following project pattern
with fb_customers_columns_names_pattern as (
    select
        "FB_GUID" as guid,
        "FB_PROFILE_URL" as profile_url,
        "FB_FULL_NAME" as full_name,
        "FB_EMAIL" as email,
        "FB_PHONE" as phone,
        "FB_COUNTRY" as country,
        "FB_SHIPPING_ADDRESS" as shipping_address 
    from {{ source('facebook', 'fb_customers') }}
),

-- Converting customers columns data types
fb_customers_columns_data_types as (
    select
        guid::varchar(36) as guid,
        profile_url::varchar(100) as profile_url,
        full_name::varchar(200) as full_name,
        email::varchar(100) as email,
        phone::varchar(20) as phone,
        country::varchar(100) as country,
        shipping_address::varchar(200) as shipping_address
    from fb_customers_columns_names_pattern
)

select * from fb_customers_columns_data_types
