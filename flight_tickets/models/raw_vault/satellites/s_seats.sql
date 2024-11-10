{{
    config(
        materialized = 'incremental'
        , schema = 'datavault2'
        , unique_key = 
    )
}}

with cte_s_seats as (
    select 
        generate_md5()
        , fare_conditions
        , generate_current_time()
        , generate_source_table
    from 
        {{ source('flights', 'seats')}}
)

select * from cte_s_seats