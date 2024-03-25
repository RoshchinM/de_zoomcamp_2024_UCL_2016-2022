{{
    config(
        materialized='view'
    )
}}


with 

source as (

    select * from {{ source('staging', 'stadiums_materialized') }}

),

renamed as (

    select
        {{ dbt.safe_cast("name", api.Column.translate_type("text")) }} as stadium_name,
        {{ dbt.safe_cast("city", api.Column.translate_type("text")) }} as city,
        {{ dbt.safe_cast("country", api.Column.translate_type("text")) }} as country,
        {{ dbt.safe_cast("capacity", api.Column.translate_type("integer")) }} as capacity
    from source

)

select * from renamed
