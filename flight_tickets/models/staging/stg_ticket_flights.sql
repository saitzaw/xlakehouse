{{
    config(
        materialized = 'incremental'
        , schema = 'staging'
    )
}}

with cte_stg_ticket_flight as (
    select
        ticket_no
        , flight_id
        , fare_conditions
        , amount
    from 
        {{ source('flights', 'ticket_flights') }}
)

select * from cte_stg_ticket_flight