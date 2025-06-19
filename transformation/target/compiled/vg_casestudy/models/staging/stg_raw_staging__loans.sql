with source as (
    select * from "casestudy"."raw"."loans"
),

renamed as (
    select
        customer_id,
        loan_id,
        
CASE
    WHEN loan_amount IS NULL THEN NULL
    -- If the value is already a valid number
    WHEN TRY_CAST(loan_amount AS DOUBLE) IS NOT NULL 
        THEN TRY_CAST(loan_amount AS DOUBLE)
    -- If contains both dot and comma (German notation)
    WHEN POSITION('.' IN loan_amount) > 0 AND POSITION(',' IN loan_amount) > 0 
        THEN TRY_CAST(REPLACE(REPLACE(TRIM(loan_amount), '.', ''), ',', '.') AS DOUBLE)
    -- If only contains comma, treat as decimal point
    WHEN POSITION(',' IN loan_amount) > 0 
        THEN TRY_CAST(REPLACE(TRIM(loan_amount), ',', '.') AS DOUBLE)
    -- If only contains dots, likely thousands separator
    WHEN POSITION('.' IN loan_amount) > 0 
        THEN TRY_CAST(REPLACE(TRIM(loan_amount), '.', '') AS DOUBLE)
    ELSE NULL
END
 as loan_amount,
        loant_type,
        
CASE
    WHEN interest_rate IS NULL THEN NULL
    -- If the value is already a valid number
    WHEN TRY_CAST(interest_rate AS DOUBLE) IS NOT NULL 
        THEN TRY_CAST(interest_rate AS DOUBLE)
    -- If contains both dot and comma (German notation)
    WHEN POSITION('.' IN interest_rate) > 0 AND POSITION(',' IN interest_rate) > 0 
        THEN TRY_CAST(REPLACE(REPLACE(TRIM(interest_rate), '.', ''), ',', '.') AS DOUBLE)
    -- If only contains comma, treat as decimal point
    WHEN POSITION(',' IN interest_rate) > 0 
        THEN TRY_CAST(REPLACE(TRIM(interest_rate), ',', '.') AS DOUBLE)
    -- If only contains dots, likely thousands separator
    WHEN POSITION('.' IN interest_rate) > 0 
        THEN TRY_CAST(REPLACE(TRIM(interest_rate), '.', '') AS DOUBLE)
    ELSE NULL
END
 as interest_rate,
        loan_term,
        
CASE
    -- First try DD.MM.YYYY format (German format with dots)
    WHEN REGEXP_MATCHES(approval_rejection_date, '^\d{1,2}\.\d{1,2}\.\d{4}$') 
        THEN TRY_CAST(STRPTIME(approval_rejection_date, '%d.%m.%Y') AS DATE)
        
    -- Then try DD/MM/YYYY format (with slashes)
    WHEN REGEXP_MATCHES(approval_rejection_date, '^\d{1,2}/\d{1,2}/\d{4}$')
        AND CAST(SPLIT_PART(approval_rejection_date, '/', 1) AS INTEGER) <= 31 
        AND CAST(SPLIT_PART(approval_rejection_date, '/', 2) AS INTEGER) <= 12 
        THEN TRY_CAST(STRPTIME(approval_rejection_date, '%d/%m/%Y') AS DATE)
        
    -- Try MM/DD/YYYY format (US format with slashes)
    WHEN REGEXP_MATCHES(approval_rejection_date, '^\d{1,2}/\d{1,2}/\d{4}$')
        AND CAST(SPLIT_PART(approval_rejection_date, '/', 1) AS INTEGER) <= 12 
        THEN TRY_CAST(STRPTIME(approval_rejection_date, '%m/%d/%Y') AS DATE)
        
    -- Try YYYY-MM-DD format (ISO format)
    WHEN REGEXP_MATCHES(approval_rejection_date, '^\d{4}-\d{1,2}-\d{1,2}$')
        THEN TRY_CAST(STRPTIME(approval_rejection_date, '%Y-%m-%d') AS DATE)
        
    -- Try generic date parsing as last resort
    ELSE TRY_CAST(approval_rejection_date AS DATE)
END
 as approval_rejection_date,
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