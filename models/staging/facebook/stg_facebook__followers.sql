
-- Renaming followers columns following project pattern
with fb_followers_columns_names_pattern as (
    select
        "FB_GUID" as guid,
        "FB_PROFILE_URL" as profile_url,
        "FB_FULL_NAME" as full_name,
        "FB_FRIENDS_NUMBER" as friends_number,
        "FB_PROFILE_DESCRIPTION" as profile_description
    from {{ ref('fb_followers') }}
),

-- Converting followers columns data types
fb_followers_columns_data_types as (
    select
        guid::varchar(36) as guid,
        profile_url::varchar(100) as profile_url,
        full_name::varchar(200) as full_name,
        friends_number::int as friends_number,
        profile_description::varchar(1000) as profile_description
    from fb_followers_columns_names_pattern
)

select * from fb_followers_columns_data_types
