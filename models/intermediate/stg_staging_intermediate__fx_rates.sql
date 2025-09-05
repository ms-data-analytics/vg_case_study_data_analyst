with staging as (
    select * from {{ ref('stg_raw_staging__fx_rates') }}
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
