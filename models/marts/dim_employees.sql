with app_employees as (
    select * from {{ ref('stg_application__employees') }}
)

select 
    app_employees.id as application_id
    , app_employees.ssn as application_ssn
    , app_employees.first_name as application_first_name
    , app_employees.last_name as application_last_name
    , app_employees.email as application_email
    , app_employees.phone as application_phone
    , app_employees.job_title as application_job_title
    , app_employees.country as application_country
    , app_employees.state as application_state
    , app_employees.city as application_city
    , app_employees.shipping_address as application_shipping_address
    , app_employees.business_address as application_business_address
    , {{ dbt_utils.generate_surrogate_key(['id']) }} as sk
from app_employees
