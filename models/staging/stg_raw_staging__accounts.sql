with source as (
    select * from {{ source('raw', 'accounts') }}
),

renamed as (
    select
        account_id,
        customer_id,
        account_type,
        {{ date_format_case('account_opening_date') }} as account_opening_date,
        account_opening_date as account_opening_date_raw
    from source
    where account_type is not null and account_type != '' and account_type != '-'
),

final as (
    select
        account_id,
        customer_id,
        account_type,
        account_opening_date,
        -- Flag records with date parsing issues
        CASE WHEN account_opening_date IS NULL AND account_opening_date_raw IS NOT NULL
             THEN TRUE ELSE FALSE 
        END as has_date_parsing_error
    from renamed
)

select * from final
