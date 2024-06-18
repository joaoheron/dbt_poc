
-- Renaming customers columns following project pattern
with customers_columns_names_pattern as (
    select
        "CUSTOMERID" as id,
        "CUSTOMERSSN" as ssn,
        "CUSTOMERFIRSTNAME" as first_name,
        "CUSTOMERLASTNAME" as last_name,
        "CUSTOMEREMAIL" as email,
        "CUSTOMERPHONE" as phone,
        "CUSTOMERJOBTITLE" as job_title,
        "CUSTOMERCOUNTRY" as country,
        "CUSTOMERSTATE" as state,
        "CUSTOMERCITY" as city,
        "CUSTOMERSHIPPINGADDRESS" as shipping_address,
        "CUSTOMERBUSINESSADDRESS" as business_address
    from {{ source('application', 'app_customers') }}

),

-- Converting customers columns data types
customers_columns_data_types as (
    select
        id::int as id,
        ssn::varchar(11) as ssn,
        first_name::varchar(100) as first_name,
        last_name::varchar(100) as last_name,
        email::varchar(100) as email,
        phone::varchar(20) as phone,
        job_title::varchar(100) as job_title,
        country::varchar(100) as country,
        state::varchar(100) as state,
        city::varchar(100) as city,
        shipping_address::varchar(200) as shipping_address,
        business_address::varchar(200) as business_address
    from customers_columns_names_pattern
)

select * from customers_columns_data_types
