with source as (
    select * from {{ source('raw', 'transactions') }}
),

renamed as (
    select
        transaction_id,
        {{ date_format_case('transaction_date') }} as transaction_date,
        transaction_date as transaction_date_raw,
        account_id,
        trim(transaction_type) as transaction_type,
        {{ convert_german_number_case('transaction_amount') }} as transaction_amount,
        trim(transaction_currency) as transaction_currency
    from source
),

final as (
    select
        transaction_id,
        transaction_date,
        account_id,
        transaction_type,
        transaction_amount,
        transaction_currency,
        -- Flag records with date parsing issues
        CASE WHEN transaction_date IS NULL AND transaction_date_raw IS NOT NULL
             THEN TRUE ELSE FALSE 
        END as has_date_parsing_error
    from renamed
)

select * from final
