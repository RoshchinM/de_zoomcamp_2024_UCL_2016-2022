{{
    config(
        materialized='view'
    )
}}


with matches as (
    select *
    from {{ ref('stg_matches') }}
), 
stadiums as (
    select *
    from {{ ref('stg_stadiums') }}
)

select matches.match_id,
       matches.season,
       matches.date_time,
       matches.home_team,
       matches.away_team,
       matches.stadium,
       matches.home_team_score,
       matches.away_team_score,
       CASE
        WHEN matches.home_team_score > matches.away_team_score THEN matches.home_team
        WHEN matches.home_team_score < matches.away_team_score THEN matches.away_team
        ELSE 'Draw' -- если ничья
       END AS winner,
       matches.penalty_shoot_out,
       matches.attendance,
       stadiums.capacity,
       CONCAT(ROUND((matches.attendance / stadiums.capacity) * 100, 0), '%') as attendance_perc
from matches
left join stadiums on matches.stadium = stadiums.stadium_name
