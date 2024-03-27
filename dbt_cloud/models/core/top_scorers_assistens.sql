
{{
    config(
        materialized='view'
    )
}}



SELECT 
    goal_scorer as player,
    goal_nationality as nationality,
    scorer_team as team,
    position,
    COUNT(goal_id) as goals,
    SUM(CASE WHEN assist IS NOT NULL THEN 1 ELSE 0 END) as assists 
from {{ ref('fact_goals') }}
GROUP BY 
    player, nationality, team, position
ORDER BY 
    goals DESC, assists DESC