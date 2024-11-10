{{
    config(
        materialized = 'incremental'
        , schema = 'datavault2'
    )
}}

with cte_h_seats as (
    select
        md5(upper(trim(aircraft_code))
            || '~'
            || upper(trim(seat_no))) as hk_seat
        , aircraft_code
        , seat_no 
        , {{ generate_current_time() }}
        , {{ generate_source_table() }}
    from 
        {{ source('flights', 'seats') }}
)

select * from cte_h_seats