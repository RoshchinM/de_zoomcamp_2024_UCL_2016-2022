{{
    config(
        materialized='view'
    )
}}


with teams as (
    select *
    from {{ ref('stg_teams') }}
), 
stadiums as (
    select *
    from {{ ref('stg_stadiums') }}
), 
managers as (
    select *
    from {{ ref('stg_managers') }}
)

select teams.team_name,
       teams.country as team_country,
       teams.home_stadium,
       stadiums.city as stadium_city,
       stadiums.capacity,
       managers.full_name,
       managers.nationality as manager_nationality,
       managers.dob as manager_dob
from teams
left join stadiums on teams.home_stadium = stadiums.stadium_name
left join managers on teams.team_name = managers.team