with source as (
    select * from {{ source('raw', 'customers') }}
),

renamed as (
    select distinct
        customer_id,
        trim(firstname) as firstname,
        trim(lastname) as lastname,
        Age as age,
        branch_id
    from source
)

select * from renamed
