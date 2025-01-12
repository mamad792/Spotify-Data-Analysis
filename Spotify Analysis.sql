-- Retrieve the names of all tracks that have more than 1 billion streams.
SELECT track, stream FROM spotify
WHERE stream > 1000000000;
-- List all albums along with their respective artists.
SELECT DISTINCT album, artist   FROM spotify;
-- Get the total number of comments for tracks where licensed = TRUE.
SELECT SUM(comments) FROM spotify
WHERE licensed = 'true';
-- Find all tracks that belong to the album type single.
SELECT artist, track, album_type FROM spotify
WHERE album_type = 'single';
-- Count the total number of tracks by each artist.
SELECT artist, COUNT(track) FROM spotify
GROUP BY artist;
-- Calculate the average danceability of tracks in each album.
SELECT album, ROUND(AVG(danceability)::NUMERIC,2) AS average_danceability FROM spotify
GROUP BY album
ORDER BY 2 DESC;
-- Find the top 5 tracks with the highest energy values.
SELECT track FROM spotify
ORDER BY energy DESC
LIMIT 5;
-- List all tracks along with their views and likes where official_video = TRUE.
SELECT track, views, likes, official_video FROM spotify
WHERE official_video = 'true';
-- For each album, calculate the total views of all associated tracks.
SELECT album, SUM(views) AS total_views FROM spotify
GROUP BY album;
-- Retrieve the track names that have been streamed on Spotify more than YouTube.
SELECT track, most_played_on FROM spotify
WHERE most_played_on = 'Spotify';
-- Find the top 3 most-viewed tracks for each artist using window functions.
SELECT artist, track, sum FROM (SELECT artist, track, SUM(views), RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) AS views_rank FROM spotify GROUP BY 1,2)
WHERE views_rank <=3;
-- Write a query to find tracks where the liveness score is above the average.
SELECT track, liveness FROM spotify
WHERE liveness > (SELECT ROUND(AVG(liveness)::NUMERIC,2) FROM spotify);
-- Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

WITH energy_calculator AS 
(
	SELECT album, MAX(energy) AS max_energy, MIN(energy) AS min_energy FROM spotify
	GROUP BY album
)


SELECT album, ROUND(max_energy::NUMERIC - min_energy::NUMERIC,3) AS energy_difference FROM energy_calculator
ORDER BY 2 DESC



