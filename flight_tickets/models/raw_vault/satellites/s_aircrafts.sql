{{
    config(
        materialized = 'incremental'
        , schema = 'flights'
        , unique_key = 'aircraft_code'
    )
}}

with cte_s_aircrafts as 
(
    select 
        generate_md5(aircraft_code) as hk_aircraft
 	    ,generate_current_time() 
        ,generate_source_table()
 	    ,model ->> 'en' as model
 	    ,range
    from 
        {{ source('flights', 'aircrafts') }}
)

select * from cte_s_aircrafts