
  
    
    

    create  table
      "casestudy"."intermediate"."stg_staging_intermediate__accounts__dbt_tmp"
  
    as (
      with staging as (
    select * from "casestudy"."staging"."stg_raw_staging__accounts"
), 
filtered as (
    select 
        account_id,
        customer_id,
        account_type,
        account_opening_date,
     from staging
    where not has_date_parsing_error
)

select * from filtered
    );
  
  