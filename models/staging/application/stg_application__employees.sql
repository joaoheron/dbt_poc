
-- Renaming employees columns following project pattern
with employees_column_names_pattern as (
    select
        "EMPLOYEEID" as id,
        "EMPLOYEESSN" as ssn,
        "EMPLOYEEFIRSTNAME" as first_name,
        "EMPLOYEELASTNAME" as last_name,
        "EMPLOYEEEMAIL" as email,
        "EMPLOYEEPHONE" as phone,
        "EMPLOYEEJOBTITLE" as job_title,
        "EMPLOYEECOUNTRY" as country,
        "EMPLOYEESTATE" as state,
        "EMPLOYEECITY" as city,
        "EMPLOYEESHIPPINGADDRESS" as shipping_address,
        "EMPLOYEEBUSINESSADDRESS" as business_address,
        "EMPLOYEEJOBSKILL" as job_skill,
        "EMPLOYEEPIN" as pin,
        "EMPLOYEEUNIVERSITYNAME" as university_name,
        "EMPLOYEEIPADDRESS" as ip_address,
        "EMPLOYEEADMISSIONDATETIME" as adminission_datetime,
        "EMPLOYEEDEACTIVATIONDATETIME" as deactivation_datetime
    from {{ source('application', 'app_employees') }}
),

-- Converting employees columns data types
employees_columns_data_types as (
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
        to_timestamp(adminission_datetime, 'YYYY-MM-DD HH24:MI:SSZ') as adminission_datetime,
        to_timestamp(deactivation_datetime, 'YYYY-MM-DD HH24:MI:SSZ') as deactivation_datetime
    from employees_column_names_pattern
)

select * from employees_columns_data_types
