{{
    config(
        materialized = 'incremental'
        , schema = 'datavault2'
    )
}}

with cte_s_aircrafts as 
(
    select 
        md5(upper(trim(aircraft_code))) as hk_aircraft
        , model ->> 'en' as model
 	    , range
 	    , {{ generate_current_time() }} 
        , {{ generate_source_table() }}
 	    
    from 
        {{ source('flights', 'aircrafts') }}
)

select * from cte_s_aircrafts