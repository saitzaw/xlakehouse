{{
    config(
        materialized = 'incremental'
        , schema = 'datavault2'
    )
}}

with cte_l_aircraft_seat as (
    select 
        md5(upper(trim(aircraft_code))
            || '~'
            || upper(trim(seat_no))) as lhk_aircraft_seat  
        , md5(upper(trim(aircraft_code))) as hk_aircraft
        ,  md5(upper(trim(aircraft_code))
            || '~'
            || upper(trim(seat_no))) as hk_seat
        , {{ generate_current_time() }} 
        , {{ generate_source_table() }}
    from 
       -- {{ source('flights', 'seats') }}
       {{ ref('stg_seats') }}
)

select * from cte_l_aircraft_seat