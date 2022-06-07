
-- Renaming products columns following project pattern
with fb_products_columns_names_pattern as (
    select
        "FB_GUID" as guid,
        "FB_APPLICATION_ID" as application_id,
        "FB_PRODUCT_URL" as product_url,
        "FB_BRAND" as brand,
        "FB_SIZE" as size,
        "FB_COLLECTION" as collection,
        "FB_COLOR" as color,
        "FB_PRICE" as price,
        "FB_CURRENCY" as currency

    from {{ ref('fb_products') }}
),

-- Converting products columns data types
fb_products_columns_data_types as (
    select
        guid::varchar(36) as guid,
        application_id::varchar(100) as application_id,
        product_url::varchar(100) as product_url,
        brand::varchar(50) as brand,
        collection::varchar(100) as collection,
        color::varchar(100) as color,
        round(price::numeric, 2) as price,
        currency::varchar(10) as currency
    from fb_products_columns_names_pattern
)

select * from fb_products_columns_data_types
