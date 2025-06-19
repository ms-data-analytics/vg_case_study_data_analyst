
  
    
    

    create  table
      "casestudy"."intermediate"."stg_staging_intermediate__customers__dbt_tmp"
  
    as (
      with staging as (
    select * from "casestudy"."staging"."stg_raw_staging__customers"
)

select * from staging
    );
  
  