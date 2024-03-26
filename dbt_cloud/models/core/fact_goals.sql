{{
    config(
        materialized='view'
    )
}}

with goals as (
    select *
    from {{ ref('stg_goals') }}
), 

players as (
    select *
    from {{ ref('stg_players') }}
), 

matches as (
    select *
    from {{ ref('stg_matches') }}
)

select g.goal_id,
       g.match_id,
       g.pid,
       g.duration as time_of_goal,
       g.goal_desc,
       p.full_name as goal_scorer,
       p.nationality as goal_nationality,
       p.position,
       p.height,
       p.weight,
       m.season,
       g.assist,
       a.full_name as assistent,
       a.nationality as assistent_nationality,
       a.position as assistent_position,
       a.height as assistent_height,
       a.weight as assistent_weight,
       m.date_time,
       m.home_team,
       m.away_team,
       m.stadium
from goals g
left join players p on g.pid = p.player_id
left join matches m on g.match_id = m.match_id
left join players a on g.assist = a.player_id
where g.pid is not null

