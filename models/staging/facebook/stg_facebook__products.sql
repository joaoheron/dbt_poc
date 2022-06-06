FB_GUID,FB_APPLICATION_ID,FB_PRODUCT_URL,FB_BRAND,FB_SIZE,FB_COLLECTION,FB_COLOR,FB_PRICE,FB_CURRENCY

-- -- Renaming products columns following project pattern
-- with fb_products_columns_names_pattern as (
--     select
--         "FB_GUID" as guid,
--         "FB_APPLICATION_ID" as application_url,
--         "FB_PRODUCT_URL" as product_url,
--         "FB_BRAND" as brand,
--         "FB_SIZE" as size,
--         "FB_COLLECTION" as collection,
--         "FB_COLOR" as color,
--         "FB_PRICE" as price,
--         "FB_CURRENCY" as currency
--     from {{ ref('fb_products') }}
-- ),

-- -- Converting products columns data types
-- fb_products_columns_data_types as (
--     select
--         guid::varchar(36) as guid,
--         application_url::varchar(100) as application_url,
--         size::varchar(10) as size,
--         collection::varchar as collection,
--         color::varchar(100) as color,
--         round(price::numeric, 2) as price,
--         currency::varchar(10) as currency
--     from fb_products_columns_names_pattern
-- )

select * from fb_products_columns_data_types
