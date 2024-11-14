{{
    config(
        materialized = 'incremental'
        , schema = 'staging'
    )
}}

with cte_stg_ticket_flight as (
    select
        ticket_no bpchar(13)
        , flight_id
        , fare_conditions
        , amount
    from 
        {{ source('flights', 'tickets_flight') }}
)

select * from cte_stg_ticket_flight