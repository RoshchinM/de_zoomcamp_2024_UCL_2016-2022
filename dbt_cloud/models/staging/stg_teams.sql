{{
    config(
        materialized='view'
    )
}}

with 

source as (

    select * from {{ source('staging', 'teams_materialized') }}

),

renamed as (

    select
        {{ dbt.safe_cast("team_name", api.Column.translate_type("text")) }} as team_name,
        {{ dbt.safe_cast("country", api.Column.translate_type("text")) }} as country,
        {{ dbt.safe_cast("home_stadium", api.Column.translate_type("text")) }} as home_stadium

    from source

)

select * from renamed
