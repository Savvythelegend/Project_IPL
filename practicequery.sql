USE RECORDS
SELECT * FROM ipl_matches_2008_2022_new

DELETE FROM ipl_matches_2008_2022_new
WHERE id IN (
    SELECT id
    FROM (
        SELECT id,
               ROW_NUMBER() OVER (PARTITION BY city, match_date, season, match_number, team1, team2, venue, toss_winner, toss_decision, superover, winning_team, won_by, margin, method, player_of_match, umpire1, umpire2 ORDER BY id) AS row_num
        FROM ipl_matches_2008_2022_new
    ) AS duplicates
    WHERE row_num > 1
);

UPDATE ipl_matches_2008_2022
SET match_date = TO_DATE(match_date, 'YYYY-MM-DD');

