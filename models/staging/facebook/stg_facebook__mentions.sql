
-- Renaming mentions columns following project pattern
with fb_mentions_columns_names_pattern as (
    select
        "FB_GUID" as guid,
        "FB_POST_URL" as post_url,
        "FB_AUTHOR_PROFILE_URL" as author_profile_url,
        "FB_AUTHOR_FULL_NAME" as author_full_name,
        "FB_CONTENT" as content,
        "FB_MEDIA" as media,
        "FB_TAGS" as tags,
        "FB_MENTIONS" as mentions,
        "FB_LIKES_NUMBER" as likes_number,
        "FB_COMMENTS_NUMBER" as comments_number,
        "FB_VIEWS_NUMBER" as views_number
    from {{ source('facebook', 'fb_mentions') }}
),

-- Converting mentions columns data types
fb_mentions_columns_data_types as (
    select
        guid::varchar(36) as guid,
        post_url::varchar(100) as post_url,
        author_profile_url::varchar(100) as profile_url,
        author_full_name::varchar(200) as author_full_name,
        content::varchar(2000) as content,
        media::varchar(1000) as media,
        array_construct(replace(replace(tags, ']', ''), '[', ''), ',') as tags,
        array_construct(replace(replace(mentions, ']', ''), '[', ''), ',') as mentions,
        likes_number::int as likes_number,
        comments_number::int as comments_number,
        views_number::int as views_number
    from fb_mentions_columns_names_pattern
)

select * from fb_mentions_columns_data_types
