with staging as (
    select * from {{ ref('stg_raw_staging__transactions') }}
),

filtered as (
    select
        transaction_id,
        transaction_date,
        account_id,
        transaction_type,
        transaction_amount,
        transaction_currency
    from staging
    where not has_date_parsing_error
)

select * from filtered
