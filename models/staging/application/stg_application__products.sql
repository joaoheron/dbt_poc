
-- Renaming products columns following project pattern
with products_columns_names_pattern as (
    select
        "ProductId" as id,
        "ProductBrand" as brand,
        "ProductSize" as size,
        "ProductCollection" as collection,
        "ProductColor" as color,
        "ProductPrice" as price,
        "ProductCurrency" as currency
    from {{ source('application', 'app_products') }}
),

-- Converting products columns data types
products_columns_data_types as (
    select
        id::int as id,
        brand::varchar as brand,
        size::varchar(10) as size,
        collection::varchar(100) as collection,
        color::varchar(100) as color,
        round(price::numeric, 2) as price,
        currency::varchar(10) as currency
    from products_columns_names_pattern
)

select * from products_columns_data_types
