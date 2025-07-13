/* Total no of matches played */

SELECT COUNT(*) AS total_matches FROM matches; 8191

/* Total no of matched by type */

SELECT match_type, COUNT(*) AS total FROM matches GROUP BY match_type;

/* Top 10 Teams with most Wins */

SELECT winner, COUNT(*) AS wins FROM matches
WHERE winner IS NOT NULL AND winner != 'draw'
GROUP BY winner
ORDER BY wins DESC
LIMIT 10;

/* Most Matches in City-wise */

SELECT city, COUNT(*) AS total
FROM matches
WHERE city != 'N/A'
GROUP BY city
ORDER BY total DESC
LIMIT 10;

/* No. of Matched in Year-wise */

SELECT SUBSTR(date, 1, 4) AS year, COUNT(*) AS total
FROM matches
GROUP BY year
ORDER BY year;

/* Distribution of results based on Wickets, runs, etc */

SELECT result_type, COUNT(*) AS count
FROM matches
WHERE result_type != 'N/A'
GROUP BY result_type;

/* Match count between Teams */

SELECT team1, team2, COUNT(*) AS total_matches
FROM matches
GROUP BY team1, team2
ORDER BY total_matches DESC
LIMIT 10;

/* No of matches ended with 'No Result' */

SELECT COUNT(*) FROM matches
WHERE winner = 'draw' OR result_type = 'N/A';

/* Average winning margin by Runs */

SELECT AVG(result_value) AS avg_runs
FROM matches
WHERE result_type = 'runs';

/* Average winning margin by Wickets */

SELECT AVG(result_value) AS avg_wickets
FROM matches
WHERE result_type = 'wickets';

/* Most 5 highest win percentage */

SELECT winner AS team,
       COUNT(*) * 100.0 / (
           SELECT COUNT(*) FROM matches
           WHERE team1 = team OR team2 = team
       ) AS win_percentage
FROM matches
WHERE winner IS NOT NULL AND winner != 'draw'
GROUP BY winner
ORDER BY win_percentage DESC
LIMIT 5;

/* Most common match with same teams */

SELECT team1, team2, COUNT(*) AS total_matches
FROM matches
GROUP BY team1, team2
ORDER BY total_matches DESC
LIMIT 10;

/* City where a specific team played most */

SELECT city, COUNT(*) AS matches_played
FROM matches
WHERE (team1 = 'India' OR team2 = 'India') AND city != 'N/A'
GROUP BY city
ORDER BY matches_played DESC
LIMIT 5;

/* Matches where the winning margin was more than 100 runs */

SELECT * FROM matches
WHERE result_type = 'runs' AND result_value > 100;

/* No of matches without result */

SELECT COUNT(*) AS no_result_matches
FROM matches
WHERE winner = 'draw' OR result_type = 'N/A' OR winner = 'N/A';

/* Year wise winning count for a specific team */

SELECT SUBSTR(date, 1, 4) AS year, COUNT(*) AS wins
FROM matches
WHERE winner = 'Australia'
GROUP BY year
ORDER BY year;

/* Total no of mathes for each team */

SELECT team, COUNT(*) AS matches_played FROM (
    SELECT team1 AS team FROM matches
    UNION ALL
    SELECT team2 AS team FROM matches
)
GROUP BY team
ORDER BY matches_played DESC
LIMIT 10;

/* Matches played per city per match type */

SELECT city, match_type, COUNT(*) AS match_count
FROM matches
WHERE city != 'N/A'
GROUP BY city, match_type
ORDER BY match_count DESC
LIMIT 10;

/* Matches with a margin of exactly 1 run or 1 wicked */

SELECT * FROM matches
WHERE (result_type = 'runs' OR result_type = 'wickets') AND result_value = 1;

/* Head to Head win count between two teams */

SELECT winner, COUNT(*) AS wins
FROM matches
WHERE (team1 = 'India' AND team2 = 'Pakistan') OR (team1 = 'Pakistan' AND team2 = 'India')
GROUP BY winner;




