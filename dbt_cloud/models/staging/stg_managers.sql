{{
    config(
        materialized='view'
    )
}}

with 

source as (

    select * from {{ source('staging', 'managers_materialized') }}

),

renamed as (

    select
        {{ dbt.safe_cast("first_name", api.Column.translate_type("text")) }} || ' ' || {{ dbt.safe_cast("last_name", api.Column.translate_type("text")) }} as full_name,
        {{ dbt.safe_cast("nationality", api.Column.translate_type("text")) }} as nationality,
        cast(dob as timestamp) as dob,
        {{ dbt.safe_cast("team", api.Column.translate_type("text")) }} as team
    from source

)

select * from renamed
