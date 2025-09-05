with source as (
    select * from {{ source('raw', 'loans') }}
),

renamed as (
    select
        customer_id,
        loan_id,
        {{ convert_german_number_case('loan_amount') }} as loan_amount,
        loant_type,
        {{ convert_german_number_case('interest_rate') }} as interest_rate,
        loan_term,
        {{ date_format_case('approval_rejection_date') }} as approval_rejection_date,
        approval_rejection_date as approval_rejection_date_raw,
        loan_status
    from source
),

final as (
    select
        customer_id,
        loan_id,
        loan_amount,
        loant_type as loan_type,
        interest_rate,
        loan_term,
        approval_rejection_date,
        loan_status,
        -- Flag records with date parsing issues
        CASE WHEN approval_rejection_date IS NULL AND approval_rejection_date_raw IS NOT NULL
             THEN TRUE ELSE FALSE 
        END as has_date_parsing_error
    from renamed
)

select * from final
