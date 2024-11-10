{% macro generate_source_table() %}

{# insert a schema and table name as source table #}
-- sql code insert in model
'{{ this.schema }}~{{ this.name }}' as load_data_src

{% endmacro %}