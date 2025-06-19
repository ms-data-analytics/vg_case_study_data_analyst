-- macros/date_utils.sql

{% macro date_format_case(column_name) %}
CASE
    -- First try DD.MM.YYYY format (German format with dots)
    WHEN REGEXP_MATCHES({{ column_name }}, '^\d{1,2}\.\d{1,2}\.\d{4}$') 
        THEN TRY_CAST(STRPTIME({{ column_name }}, '%d.%m.%Y') AS DATE)
        
    -- Then try DD/MM/YYYY format (with slashes)
    WHEN REGEXP_MATCHES({{ column_name }}, '^\d{1,2}/\d{1,2}/\d{4}$')
        AND CAST(SPLIT_PART({{ column_name }}, '/', 1) AS INTEGER) <= 31 
        AND CAST(SPLIT_PART({{ column_name }}, '/', 2) AS INTEGER) <= 12 
        THEN TRY_CAST(STRPTIME({{ column_name }}, '%d/%m/%Y') AS DATE)
        
    -- Try MM/DD/YYYY format (US format with slashes)
    WHEN REGEXP_MATCHES({{ column_name }}, '^\d{1,2}/\d{1,2}/\d{4}$')
        AND CAST(SPLIT_PART({{ column_name }}, '/', 1) AS INTEGER) <= 12 
        THEN TRY_CAST(STRPTIME({{ column_name }}, '%m/%d/%Y') AS DATE)
        
    -- Try YYYY-MM-DD format (ISO format)
    WHEN REGEXP_MATCHES({{ column_name }}, '^\d{4}-\d{1,2}-\d{1,2}$')
        THEN TRY_CAST(STRPTIME({{ column_name }}, '%Y-%m-%d') AS DATE)
        
    -- Try generic date parsing as last resort
    ELSE TRY_CAST({{ column_name }} AS DATE)
END
{% endmacro %}

{% macro convert_german_number_case(column_name) %}
CASE
    WHEN {{ column_name }} IS NULL THEN NULL
    -- If the value is already a valid number
    WHEN TRY_CAST({{ column_name }} AS DOUBLE) IS NOT NULL 
        THEN TRY_CAST({{ column_name }} AS DOUBLE)
    -- If contains both dot and comma (German notation)
    WHEN POSITION('.' IN {{ column_name }}) > 0 AND POSITION(',' IN {{ column_name }}) > 0 
        THEN TRY_CAST(REPLACE(REPLACE(TRIM({{ column_name }}), '.', ''), ',', '.') AS DOUBLE)
    -- If only contains comma, treat as decimal point
    WHEN POSITION(',' IN {{ column_name }}) > 0 
        THEN TRY_CAST(REPLACE(TRIM({{ column_name }}), ',', '.') AS DOUBLE)
    -- If only contains dots, likely thousands separator
    WHEN POSITION('.' IN {{ column_name }}) > 0 
        THEN TRY_CAST(REPLACE(TRIM({{ column_name }}), '.', '') AS DOUBLE)
    ELSE NULL
END
{% endmacro %}
