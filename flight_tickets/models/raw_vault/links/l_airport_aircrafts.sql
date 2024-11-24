{{
    config(
        materailized = 'incremental'
        , schema = 'datavault2'
    )
}}

with cte_l_airport_aircraft as (
    md5(
        upper(trim(flight_id))
        || '~'
        upper(trim(departure_airport))
        || '~'
        upper(trim(arrival_airport))
        || '~'
        upper(trim(aircraft_code))
    ) as lhk_flight_airport_aircraft
    , md5(upper(trim(departure_airport))) as hk_departure_airport
    , md5(upper(trim(arrival_airport))) as hk_arrival_airport
	, md5(upper(trim(aircraft_code))) as hk_aircraft
	, flight_id 
    , {{ generate_current_time() }} 
    , {{ generate_source_table() }}
)
select * from cte_l_airport_aircraft