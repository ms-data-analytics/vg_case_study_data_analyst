
  
    
    

    create  table
      "casestudy"."intermediate"."stg_staging_intermediate__loans__dbt_tmp"
  
    as (
      with staging as (
    select * from "casestudy"."staging"."stg_raw_staging__loans"
),

filtered as (
    select
        customer_id,
        loan_id,
        loan_amount,
        loan_type,
        interest_rate,
        loan_term,
        approval_rejection_date,
        loan_status
    from staging
    where not has_date_parsing_error
)

select * from filtered
    );
  
  