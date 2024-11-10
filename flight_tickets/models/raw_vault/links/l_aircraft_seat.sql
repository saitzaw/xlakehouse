{{
    config(
        materialized = 'incremental'
        , schema = 'datavault2'
        , unique_key = generate_md5([aircraft_code, seat_no])
    )
}}

with cte_l_aircraft_seat as (
    select 
        generate_md5([aircraft_code, seat_no]) as lhk_aircraft_seat
        , generate_md5([aircraft_code]) as hk_aircraft
        , generate_md5([aircraft_code, seat_no]) as hk_seat
        , generate_current_time()
        , generate_source_table()
    from 
        {{ source('flights', 'seats') }}
)

select * from cte_l_aircraft_seat