{{
    config(
        materialized = 'incremental'
        , schema = 'datavault2'
        , unique_key = generate_md5([aircraft_code])
    )
}}

with cte_h_flight as (

    select 
        generate_md5([aircraft_code]) as hk_aircraft
	    ,aircraft_code 
	    ,generate_current_time() 
        ,generate_source_table()
    from 
        {{ source('flights', 'aircrafts') }}
)

select * from cte_h_flight