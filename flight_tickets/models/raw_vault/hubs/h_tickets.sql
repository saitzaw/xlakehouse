{{
    config(
        materialized = 'incremental'
        , schema = 'datavault2'
    )
}}

with cte_h_tickets as (
    select 
        md5(upper(trim(ticket_no))) as hk_ticket
        , ticket_no
        , {{ generate_current_time() }}
        , {{ generate_source_table() }}
    from 
        {{ ref('stg_tickets') }}
)
select * from cte_h_tickets