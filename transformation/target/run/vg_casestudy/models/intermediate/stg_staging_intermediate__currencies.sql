
  
    
    

    create  table
      "casestudy"."intermediate"."stg_staging_intermediate__currencies__dbt_tmp"
  
    as (
      with staging as (
    select * from "casestudy"."raw"."currencies"
),
cleaned as (
    select distinct
        trim(currency) as currency,
        trim(currency_iso_code) as currency_iso_code,
    from staging
    where currency_iso_code is not null and trim(currency_iso_code) != '(none)'
)

select * from cleaned
    );
  
  