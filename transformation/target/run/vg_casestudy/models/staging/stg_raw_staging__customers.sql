
  
  create view "casestudy"."staging"."stg_raw_staging__customers__dbt_tmp" as (
    with source as (
    select * from "casestudy"."raw"."customers"
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
  );
