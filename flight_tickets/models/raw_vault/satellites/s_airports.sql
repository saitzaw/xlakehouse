{{
    config(
        materialized = 'incremental'
        , schema = 'datavault2'
    )
}}

with cte_s_airports as (
    select 
        md5(upper(trim(airport_code))) as hk_airport
        , airport_name 
        , city
        , coordinates
        , timezone
        , {{ generate_current_time() }} 
        , {{ generate_source_table() }}
    from 
    {{ ref("stg_airports") }}
)

select * from cte_s_airports