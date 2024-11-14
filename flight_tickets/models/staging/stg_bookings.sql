{{
    config(
        materialized = 'incremental'
        , schema = 'staging'
    )
}}

with cte_stg_bookings as (
    select 
        book_ref
	    , book_date
	    , total_amount
    from 
       {{ source('flights', 'bookings') }} 
)
select * from cte_stg_bookings