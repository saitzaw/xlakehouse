{% macro generate_current_time() %}

{# current load time as insert date in data vault 2 #}

current_timestamp() as load_time_ts

{% endmacro %}