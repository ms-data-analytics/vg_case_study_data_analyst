with staging as (
    select * from {{ ref('stg_raw_staging__loans') }}
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
