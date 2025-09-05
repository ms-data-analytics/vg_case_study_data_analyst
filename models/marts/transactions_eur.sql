{{ config(materialized='table') }}
-- Dieses Modell summiert Transaktionen in EUR je Kunde, Konto, Filiale und Datum.
-- Währungsumrechnung:
--  - EUR -> Kurs = 1
--  - andere Währungen -> nimm den letzten bekannten Kurs am Transaktionsdatum oder davor

with t as (
    -- Staging-Tabellen nutzen (bereits bereinigt/typisiert)
    select
        tr.transaction_id,
        tr.transaction_date,         -- bereits als DATE formatiert
        tr.account_id,
        tr.transaction_amount,       -- bereits NUMERIC/DOUBLE
        tr.transaction_currency
    from staging.stg_raw_staging__transactions tr
),

a as (
    select
        account_id,
        customer_id
    from staging.stg_raw_staging__accounts
),

c as (
    select
        customer_id,
        branch_id
    from staging.stg_raw_staging__customers
),

-- Für jeden Vorgang den passenden fx_kurs ermitteln:
--  - Wenn EUR -> 1
--  - sonst: den zuletzt bekannten Kurs (<= Transaktionsdatum)
t_with_fx as (
    select
        c.customer_id,
        c.branch_id,
        t.account_id,
        transaction_id,
        t.transaction_date,

        -- Kurs bestimmen
        case
            when upper(t.transaction_currency) = 'EUR' then 1.0
            else (
                select f.fx_rate
                from staging.stg_raw_staging__fx_rates f
                where upper(f.currency_iso_code) = upper(t.transaction_currency)
                  and f.fx_rate_date <= t.transaction_date
                order by f.fx_rate_date desc
                limit 1
            )
        end as fx_rate,

        -- Betrag in EUR (nur rechnen, wenn Kurs vorhanden)
        case
            when upper(t.transaction_currency) = 'EUR' then t.transaction_amount
            else t.transaction_amount / (
                select f.fx_rate
                from staging.stg_raw_staging__fx_rates f
                where upper(f.currency_iso_code) = upper(t.transaction_currency)
                  and f.fx_rate_date <= t.transaction_date
                order by f.fx_rate_date desc
                limit 1
            )
        end as amount_eur
    from t
    join a on t.account_id = a.account_id
    join c on a.customer_id = c.customer_id
)

select
    customer_id,
    branch_id,
    account_id,
    transaction_id,
    transaction_date,
    -- Summe in EUR (NULL-Werte werden ignoriert)
    sum(amount_eur) as total_amount_eur
from t_with_fx
group by 1,2,3,4,5