with app_products as (
    select * from {{ ref('stg_application__products') }}
),

fb_products as (
    select * from {{ ref('stg_facebook__products') }}
),

app_fb_products as (
    select
        app_products.id as application_id
        , app_products.brand as application_brand
        , app_products.size as application_size
        , app_products.collection as application_collection
        , app_products.color as application_color
        , app_products.price as application_price
        , app_products.currency as application_currency
        , fb_products.guid as facebook_guid
        , fb_products.product_url as facebook_product_url
        , fb_products.brand as facebook_brand
        , fb_products.collection as facebook_collection
        , fb_products.color as facebook_color
        , fb_products.price as facebook_price
        , fb_products.currency as facebook_currency
    from app_products
        full outer join fb_products 
        on app_products.id = fb_products.application_id
)

select
    {{ dbt_utils.generate_surrogate_key(['application_id', 'facebook_guid']) }} as sk
    , afp.* 
from app_fb_products afp
