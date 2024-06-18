{# in dbt Develop #}

{% set old_etl_relation=ref('stg_application__customers') -%}

{% set dbt_relation=ref('stg_facebook__customers') %}

{{ audit_helper.compare_relations(
    a_relation=old_etl_relation,
    b_relation=dbt_relation,
    primary_key="order_id"
) }}
