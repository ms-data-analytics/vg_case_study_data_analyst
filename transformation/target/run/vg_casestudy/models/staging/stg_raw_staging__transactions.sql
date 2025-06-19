
  
  create view "casestudy"."staging"."stg_raw_staging__transactions__dbt_tmp" as (
    with source as (
    select * from "casestudy"."raw"."transactions"
),

renamed as (
    select
        transaction_id,
        
CASE
    -- First try DD.MM.YYYY format (German format with dots)
    WHEN REGEXP_MATCHES(transaction_date, '^\d{1,2}\.\d{1,2}\.\d{4}$') 
        THEN TRY_CAST(STRPTIME(transaction_date, '%d.%m.%Y') AS DATE)
        
    -- Then try DD/MM/YYYY format (with slashes)
    WHEN REGEXP_MATCHES(transaction_date, '^\d{1,2}/\d{1,2}/\d{4}$')
        AND CAST(SPLIT_PART(transaction_date, '/', 1) AS INTEGER) <= 31 
        AND CAST(SPLIT_PART(transaction_date, '/', 2) AS INTEGER) <= 12 
        THEN TRY_CAST(STRPTIME(transaction_date, '%d/%m/%Y') AS DATE)
        
    -- Try MM/DD/YYYY format (US format with slashes)
    WHEN REGEXP_MATCHES(transaction_date, '^\d{1,2}/\d{1,2}/\d{4}$')
        AND CAST(SPLIT_PART(transaction_date, '/', 1) AS INTEGER) <= 12 
        THEN TRY_CAST(STRPTIME(transaction_date, '%m/%d/%Y') AS DATE)
        
    -- Try YYYY-MM-DD format (ISO format)
    WHEN REGEXP_MATCHES(transaction_date, '^\d{4}-\d{1,2}-\d{1,2}$')
        THEN TRY_CAST(STRPTIME(transaction_date, '%Y-%m-%d') AS DATE)
        
    -- Try generic date parsing as last resort
    ELSE TRY_CAST(transaction_date AS DATE)
END
 as transaction_date,
        transaction_date as transaction_date_raw,
        account_id,
        trim(transaction_type) as transaction_type,
        
CASE
    WHEN transaction_amount IS NULL THEN NULL
    -- If the value is already a valid number
    WHEN TRY_CAST(transaction_amount AS DOUBLE) IS NOT NULL 
        THEN TRY_CAST(transaction_amount AS DOUBLE)
    -- If contains both dot and comma (German notation)
    WHEN POSITION('.' IN transaction_amount) > 0 AND POSITION(',' IN transaction_amount) > 0 
        THEN TRY_CAST(REPLACE(REPLACE(TRIM(transaction_amount), '.', ''), ',', '.') AS DOUBLE)
    -- If only contains comma, treat as decimal point
    WHEN POSITION(',' IN transaction_amount) > 0 
        THEN TRY_CAST(REPLACE(TRIM(transaction_amount), ',', '.') AS DOUBLE)
    -- If only contains dots, likely thousands separator
    WHEN POSITION('.' IN transaction_amount) > 0 
        THEN TRY_CAST(REPLACE(TRIM(transaction_amount), '.', '') AS DOUBLE)
    ELSE NULL
END
 as transaction_amount,
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
  );
