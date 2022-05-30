
-- Renaming employees columns following project pattern
with employees_column_names_pattern as (
    select
        EmployeeId as id,
        EmployeeSsn as ssn,
        EmployeeFirstName as first_name,
        EmployeeLastName as last_name,
        EmployeeEmail as email,
        EmployeePhone as phone,
        EmployeeJobTitle as job_title,
        EmployeeCountry as country,
        EmployeeState as state,
        EmployeeCity as city,
        EmployeeShippingAddress as shipping_address,
        EmployeeBusinessAddress as business_address,
        EmployeeJobSkill as job_skill,
        EmployeePin as pin,
        EmployeeUniversityName as university_name,
        EmployeeIpAddress as ip_address,
        EmployeeAdmissionDatetime as adminission_datetime,
        EmployeeDeactivationDatetime as deactivation_datetime
    from {{ ref('app_employees') }}
),

-- Converting employees columns data types
products_columns_data_types as (
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
        business_address::varchar(200) as business_address,
        job_skill::varchar(100) as job_skill,
        pin::varchar(20) as pin,
        university_name::varchar(100) as university_name,
        ip_address::varchar(100) as ip_address,
        to_timestamp(adminission_datetime, 'YYYY-MM-DD HH24:MI:SS') as adminission_datetime,
        to_timestamp(deactivation_datetime, 'YYYY-MM-DD HH24:MI:SS') as deactivation_datetime
    from products_columns_names_pattern
)

select * from products_columns_data_types
