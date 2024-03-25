{{
    config(
        materialized='view'
    )
}}

with 

source as (

    select * from {{ source('staging', 'matches_materialized') }}

),

renamed as (

    select
        {{ dbt.safe_cast("match_id", api.Column.translate_type("text")) }} as match_id,
        {{ dbt.safe_cast("season", api.Column.translate_type("text")) }} as season,
        PARSE_TIMESTAMP('%d-%b-%y %I.%M.%S.000000000 %p', date_time) AS date_time,
        {{ dbt.safe_cast("home_team", api.Column.translate_type("text")) }} as home_team,
        {{ dbt.safe_cast("away_team", api.Column.translate_type("text")) }} as away_team,
        {{ dbt.safe_cast("stadium", api.Column.translate_type("text")) }} as stadium,
        {{ dbt.safe_cast("home_team_score", api.Column.translate_type("integer")) }} as home_team_score,
        {{ dbt.safe_cast("away_team_score", api.Column.translate_type("integer")) }} as away_team_score,
        {{ dbt.safe_cast("penalty_shoot_out", api.Column.translate_type("text")) }} as penalty_shoot_out,
        {{ dbt.safe_cast("attendance", api.Column.translate_type("integer")) }} as attendance
    from source


)

select * from renamed
