{% macro generate_current_time() %}

{# current load time as insert date in data vault 2 #}
-- SQL code return 
 CAST(current_timestamp(0) AS timestamptz) AS load_time_ts

{% endmacro %}