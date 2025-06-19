
  
    
    

    create  table
      "casestudy"."intermediate"."stg_staging_intermediate__fx_rates__dbt_tmp"
  
    as (
      with staging as (
    select * from "casestudy"."staging"."stg_raw_staging__fx_rates"
),

filtered as (
    select
        currency_iso_code,
        fx_rate,
        fx_rate_date
    from staging
    where not has_date_parsing_error
)

select * from filtered
    );
  
  