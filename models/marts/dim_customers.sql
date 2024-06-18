with app_customers as (
    select * from {{ ref('stg_application__customers') }}
),

fb_customers as (
    select * from {{ ref('stg_facebook__customers') }}
),

app_fb_customers as (
    select
        app_customers.id as application_id
        , app_customers.ssn as application_ssn
        , app_customers.first_name as application_first_name
        , app_customers.last_name as application_last_name
        , app_customers.email as application_email
        , app_customers.phone as application_phone
        , app_customers.job_title as application_job_title
        , app_customers.country as application_country
        , app_customers.state as application_state
        , app_customers.city as application_city
        , app_customers.shipping_address as application_shipping_address
        , app_customers.business_address as application_business_address
        , fb_customers.guid as facebook_guid
        , fb_customers.profile_url as facebook_profile_url
        , fb_customers.full_name as facebook_full_name
        , fb_customers.email as facebook_email
        , fb_customers.phone as facebook_phone
        , fb_customers.country as facebook_country
        , fb_customers.shipping_address as facebook_shipping_address
    from app_customers
        full outer join fb_customers
        on app_customers.email = fb_customers.email
        or app_customers.phone = fb_customers.phone
)

select 
    {{ dbt_utils.generate_surrogate_key(['application_id', 'facebook_guid']) }} as sk
    , *
from app_fb_customers 
