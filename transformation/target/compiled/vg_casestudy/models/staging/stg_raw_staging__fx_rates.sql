with source as (
    select * from "casestudy"."raw"."fx_rates"
),

renamed as (
    select
        trim(currency_iso_code) as currency_iso_code,
        
CASE
    WHEN fx_rate IS NULL THEN NULL
    -- If the value is already a valid number
    WHEN TRY_CAST(fx_rate AS DOUBLE) IS NOT NULL 
        THEN TRY_CAST(fx_rate AS DOUBLE)
    -- If contains both dot and comma (German notation)
    WHEN POSITION('.' IN fx_rate) > 0 AND POSITION(',' IN fx_rate) > 0 
        THEN TRY_CAST(REPLACE(REPLACE(TRIM(fx_rate), '.', ''), ',', '.') AS DOUBLE)
    -- If only contains comma, treat as decimal point
    WHEN POSITION(',' IN fx_rate) > 0 
        THEN TRY_CAST(REPLACE(TRIM(fx_rate), ',', '.') AS DOUBLE)
    -- If only contains dots, likely thousands separator
    WHEN POSITION('.' IN fx_rate) > 0 
        THEN TRY_CAST(REPLACE(TRIM(fx_rate), '.', '') AS DOUBLE)
    ELSE NULL
END
 as fx_rate,
        
CASE
    -- First try DD.MM.YYYY format (German format with dots)
    WHEN REGEXP_MATCHES(date, '^\d{1,2}\.\d{1,2}\.\d{4}$') 
        THEN TRY_CAST(STRPTIME(date, '%d.%m.%Y') AS DATE)
        
    -- Then try DD/MM/YYYY format (with slashes)
    WHEN REGEXP_MATCHES(date, '^\d{1,2}/\d{1,2}/\d{4}$')
        AND CAST(SPLIT_PART(date, '/', 1) AS INTEGER) <= 31 
        AND CAST(SPLIT_PART(date, '/', 2) AS INTEGER) <= 12 
        THEN TRY_CAST(STRPTIME(date, '%d/%m/%Y') AS DATE)
        
    -- Try MM/DD/YYYY format (US format with slashes)
    WHEN REGEXP_MATCHES(date, '^\d{1,2}/\d{1,2}/\d{4}$')
        AND CAST(SPLIT_PART(date, '/', 1) AS INTEGER) <= 12 
        THEN TRY_CAST(STRPTIME(date, '%m/%d/%Y') AS DATE)
        
    -- Try YYYY-MM-DD format (ISO format)
    WHEN REGEXP_MATCHES(date, '^\d{4}-\d{1,2}-\d{1,2}$')
        THEN TRY_CAST(STRPTIME(date, '%Y-%m-%d') AS DATE)
        
    -- Try generic date parsing as last resort
    ELSE TRY_CAST(date AS DATE)
END
 as fx_rate_date,
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