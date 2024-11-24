{{
    config(
        materialized = 'incremental'
        , schema = 'datavault2'
    )
}}

with cte_s_flights as (
    select 
        md5(
		upper(trim(flight_id)) 
		|| '~'
		|| upper(trim(departure_airport))
		|| '~'
		|| upper(trim(arrival_airport))
		|| '~'
		|| upper(trim(aircraft_code))
	) as lhk_flight_airport_aircraft
	, flight_no
	, scheduled_departure
	, scheduled_arrival
	, actual_departure
	, actual_arrival
	, status
    , {{ generate_current_time() }}
    , {{ generate_source_table() }}
    from 
    {{ ref("stg_flights") }}
)
select * from cte_s_flights