{{
    config(
        materialized = 'incremental'
        , schema = 'datavault2' 
    )
}}

with cte_h_airports as (
    select 
        md5(upper(trim(airport_code))) as hk_airport
        , airport_code
        , {{ generate_current_time() }}
        , {{ generate_source_table() }}
    from 
    {{ ref("stg_airports") }}
)
select * from cte_h_airports