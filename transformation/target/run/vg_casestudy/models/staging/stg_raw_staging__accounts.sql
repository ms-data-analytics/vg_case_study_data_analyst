
  
  create view "casestudy"."staging"."stg_raw_staging__accounts__dbt_tmp" as (
    with source as (
    select * from "casestudy"."raw"."accounts"
),

renamed as (
    select
        account_id,
        customer_id,
        account_type,
        
CASE
    -- First try DD.MM.YYYY format (German format with dots)
    WHEN REGEXP_MATCHES(account_opening_date, '^\d{1,2}\.\d{1,2}\.\d{4}$') 
        THEN TRY_CAST(STRPTIME(account_opening_date, '%d.%m.%Y') AS DATE)
        
    -- Then try DD/MM/YYYY format (with slashes)
    WHEN REGEXP_MATCHES(account_opening_date, '^\d{1,2}/\d{1,2}/\d{4}$')
        AND CAST(SPLIT_PART(account_opening_date, '/', 1) AS INTEGER) <= 31 
        AND CAST(SPLIT_PART(account_opening_date, '/', 2) AS INTEGER) <= 12 
        THEN TRY_CAST(STRPTIME(account_opening_date, '%d/%m/%Y') AS DATE)
        
    -- Try MM/DD/YYYY format (US format with slashes)
    WHEN REGEXP_MATCHES(account_opening_date, '^\d{1,2}/\d{1,2}/\d{4}$')
        AND CAST(SPLIT_PART(account_opening_date, '/', 1) AS INTEGER) <= 12 
        THEN TRY_CAST(STRPTIME(account_opening_date, '%m/%d/%Y') AS DATE)
        
    -- Try YYYY-MM-DD format (ISO format)
    WHEN REGEXP_MATCHES(account_opening_date, '^\d{4}-\d{1,2}-\d{1,2}$')
        THEN TRY_CAST(STRPTIME(account_opening_date, '%Y-%m-%d') AS DATE)
        
    -- Try generic date parsing as last resort
    ELSE TRY_CAST(account_opening_date AS DATE)
END
 as account_opening_date,
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
  );
