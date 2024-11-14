{{
    config(
        materialized = 'incremental'
        , schema = 'staging'
    )
}}

with cte_stg_tickets as (
    select 
        ticket_no
        , book_ref
        , passenger_id
        , passenger_name
        , contact_data
    from 
        {{ source('flights', 'tickets') }}
)

select * from cte_stg_tickets