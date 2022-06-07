
-- Renaming products columns following project pattern
with fb_reviews_columns_names_pattern as (
    select
        "FB_GUID" as guid,
        "FB_REVIEWER_PROFILE_URL" as reviewer_profile_url,
        "FB_REVIEWER_FULL_NAME" as reviewer_full_name,
        "FB_STARS_NUMBER" as stars_number,
        "FB_CONTENT" as content
    from {{ ref('fb_reviews') }}
),

-- Converting products columns data types
fb_reviews_columns_data_types as (
    select
        guid::varchar(36) as guid,
        reviewer_profile_url::varchar(100) as reviewer_profile_url,
        reviewer_full_name::varchar(200) as reviewer_full_name,
        stars_number::int as stars_number,
        content::varchar(1000) as content
    from fb_reviews_columns_names_pattern
)

select * from fb_reviews_columns_data_types
