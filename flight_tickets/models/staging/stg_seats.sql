{{
    config(
        materialized = 'incremental'
        , schema = 'staging'
    )
}}

with cte_stg_seats as (
    select
        aircraft_code
	    , seat_no
	    , fare_conditions
    from 
       {{ source('flights', 'seats') }}
)

select * from cte_stg_seats