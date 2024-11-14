{{
    config(
        materialized = 'incremental'
        , schema = 'staging'
    )
}}

with cte_stg_flights as (
    select 
        flight_id
        , flight_no
        , scheduled_departure
        , scheduled_arrival
        , departure_airport
        , arrival_airport
        , status
        , aircraft_code
        , actual_departure
        , actual_arrival
    from 
       {{ source('flights', 'flights') }} 
)
    select * from cte_stg_flights