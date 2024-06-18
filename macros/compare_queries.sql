
{# in dbt Develop #}

{% set raw_app_backup %}
  select *
  from raw.application_backup.app_customers
{% endset %}

{% set raw_app %}
  select *
  from {{ ref('app_customers') }}
{% endset %}

{{ audit_helper.compare_queries(
    a_query=raw_app,
    b_query=raw_app_backup,
    primary_key="order_id"
) }}