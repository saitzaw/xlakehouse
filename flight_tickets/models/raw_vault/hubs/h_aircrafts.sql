{{
    config(
        materialized = 'incremental'
        , schema = 'datavault2'
    )
}}

with cte_h_flight as (

    select 
        -- md5(upper(trim(aircraft_code))) as hk_aircraft
        {{ generate_md5([aircraft_code]) }} as hk_aircraft
	    , aircraft_code 
	    , {{ generate_current_time() }}
        , {{ generate_source_table() }}
    from 
        {{ source('flights', 'aircrafts') }}
)

select * from cte_h_flight