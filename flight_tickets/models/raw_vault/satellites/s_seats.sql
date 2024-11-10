{{
    config(
        materialized = 'incremental'
        , schema = 'datavault2'
        , unique_key = generate_md5('aircraft_code, seat_no')
    )
}}

with cte_s_seats as (
    select 
        md5(upper(trim(aircraft_code))
            || '~'
            || upper(trim(seat_no))) as hk_seat
        , fare_conditions
        , {{ generate_current_time() }}
        , {{ generate_source_table() }}
    from 
        {{ source('flights', 'seats')}}
)

select * from cte_s_seats