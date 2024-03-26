with 

source as (

    select * from {{ source('staging', 'players_materialized') }}

),

renamed as (

    select
        {{ dbt.safe_cast("player_id", api.Column.translate_type("text")) }} as player_id,
COALESCE(
    CONCAT({{ dbt.safe_cast("first_name", api.Column.translate_type("text")) }}, ' ', {{ dbt.safe_cast("last_name", api.Column.translate_type("text")) }}),
    {{ dbt.safe_cast("last_name", api.Column.translate_type("text")) }}
) AS full_name,
        {{ dbt.safe_cast("first_name", api.Column.translate_type("text")) }} as first_name,
        {{ dbt.safe_cast("last_name", api.Column.translate_type("text")) }} as last_name,
        {{ dbt.safe_cast("nationality", api.Column.translate_type("text")) }} as nationality,
        cast(dob as timestamp) as date_of_birth,
        {{ dbt.safe_cast("team", api.Column.translate_type("text")) }} as team,
        {{ dbt.safe_cast("jersey_number", api.Column.translate_type("text")) }} as jersey_number,
        {{ dbt.safe_cast("position", api.Column.translate_type("text")) }} as position,
        {{ dbt.safe_cast("height", api.Column.translate_type("text")) }} as height,
        {{ dbt.safe_cast("weight", api.Column.translate_type("text")) }} as weight,
        {{ dbt.safe_cast("foot", api.Column.translate_type("text")) }} as foot
    from source

)

select * from renamed
