{% macro generate_md5(columns) %}

{# This is a macro for generate md5 based checksum value for business key#}

{{
    return(
        md5(
            upper(
                trim(''.join(columns))
                )
            )
        )
}}

{% endmacro %}