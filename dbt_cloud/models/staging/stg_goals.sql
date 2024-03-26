{{
    config(
        materialized='view'
    )
}}

with 

source as (

    select * from {{ source('staging', 'goals_materialized') }}

),

renamed as (

    SELECT
    {{ dbt.safe_cast("goal_id", api.Column.translate_type("text")) }} as goal_id,
    {{ dbt.safe_cast("match_id", api.Column.translate_type("text")) }} as match_id,
    {{ dbt.safe_cast("pid", api.Column.translate_type("text")) }} as pid,
    {{ dbt.safe_cast("duration", api.Column.translate_type("text")) }} as duration,
    {{ dbt.safe_cast("assist", api.Column.translate_type("text")) }} as assist,
    {{ dbt.safe_cast("goal_desc", api.Column.translate_type("text")) }} as goal_desc
FROM source
Where pid is not null

)

select * from renamed
