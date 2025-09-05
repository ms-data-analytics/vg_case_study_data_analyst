with staging as (
    select * from {{ ref("stg_raw_staging__customers") }}
)

select * from staging 
