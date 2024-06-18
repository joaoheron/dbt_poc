{% macro insert_custom_customer() %}

    INSERT INTO {{ env_var('DBT_SCHEMA') }}.dim_customers (
    sk
    , application_id
    , facebook_guid            
    ) 
    VALUES ( 
        '-9999', -9999, '-9999'
    )

{% endmacro %}
