Transformation plan: 

Transformation:
###combine all 3 models in 1 with joins
SELECT * FROM `zoomcamp-ucl-data-mr.UCL.teams_materialized` 
SELECT * FROM `zoomcamp-ucl-data-mr.UCL.stadiums_materialized` 
SELECT * FROM `zoomcamp-ucl-data-mr.UCL.managers_materialized` 


SELECT * FROM `zoomcamp-ucl-data-mr.UCL.matches_materialized` 
###add winner column and attendance % from capacity (join capacity from stadiums)

SELECT * FROM `zoomcamp-ucl-data-mr.UCL.goals_materialized` 
SELECT * FROM `zoomcamp-ucl-data-mr.UCL.players_materialized` 
### add players total goals and assists leaderboard