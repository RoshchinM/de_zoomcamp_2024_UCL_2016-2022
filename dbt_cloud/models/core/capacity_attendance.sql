
{{
    config(
        materialized='view'
    )
}}



SELECT 
    fteams.home_stadium,
    fteams.team_name,
    fteams.stadium_city,
    fteams.team_country,
    COUNT(fmatches.match_id) as total_matches,
    AVG(fmatches.attendance) as avg_attendance
FROM 
    {{ ref('fact_matches') }} fmatches
JOIN 
    {{ ref('fact_teams') }} fteams ON fmatches.home_team = fteams.team_name
GROUP BY 
    fteams.home_stadium, fteams.team_name, fteams.stadium_city, fteams.team_country
ORDER BY 
    avg_attendance DESC, total_matches DESC