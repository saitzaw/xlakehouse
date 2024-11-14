{{
    config(
        materialized = 'incremental'
        , schema = 'staging'
    )
}}

with cte_stg_airports as (
    select 
        airport_code
        , airport_name
        , city
        , coordinates
        , timezone
    from 
        {{ source('flights', 'airports') }}
)
select * from cte_stg_airports