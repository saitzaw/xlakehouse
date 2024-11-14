{{
    config(
        materialized = 'incremental'
        , schema = 'staging'
    )
}}

with cte_stg_aircraft as (
    select 
        aircraft_code
	    , model
	    , range
    from 
    {{ source('flights', 'aircrafts') }} 
)
select * from cte_stg_aircraft