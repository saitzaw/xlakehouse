{{
    config(
        materialized = 'incremental'
        , schema = 'staging'
    )
}}

with cte_stg_boarding_passes as (
    select 
        ticket_no
        , flight_id
        , boarding_no
        , seat_no
    from 
        {{ source('flights', 'boarding_passes') }}
)

select * from cte_stg_boarding_passes