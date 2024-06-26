{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- elif node.resource_type == "seed" -%}

        {{ custom_schema_name | trim }}

    {%- else -%}

        {%- if target.name == "dev" -%}

            {{ default_schema }}_{{ custom_schema_name | trim }}
        
        {%- else -%}

            {{ custom_schema_name | trim }}

        {%- endif -%}

    {%- endif -%}

{%- endmacro %}
