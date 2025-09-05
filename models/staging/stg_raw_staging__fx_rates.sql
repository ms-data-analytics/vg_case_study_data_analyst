with source as (
    select * from {{ source('raw', 'fx_rates') }}
),

renamed as (
    select
        trim(currency_iso_code) as currency_iso_code,
        {{ convert_german_number_case('fx_rate') }} as fx_rate,
        {{ date_format_case('date') }} as fx_rate_date,
        date as fx_rate_date_raw
    from source
    where currency_iso_code is not null and trim(currency_iso_code) not in  ('(none)', '')
),

final as (
    select
        currency_iso_code,
        fx_rate,
        fx_rate_date,
        -- Flag records with date parsing issues
        CASE WHEN fx_rate_date IS NULL AND fx_rate_date_raw IS NOT NULL
             THEN TRUE ELSE FALSE 
        END as has_date_parsing_error
    from renamed
)

select * from final
