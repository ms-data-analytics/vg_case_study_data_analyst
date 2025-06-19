with staging as (
    select * from "casestudy"."staging"."stg_raw_staging__customers"
)

select * from staging