WITH mode_counts AS(
	SELECT
		title, 
		description,
		release_year,
		rating,
		last_update,
		special_features,
		fulltext,
		COUNT(*) AS count,
		ROW_NUMBER() OVER (PARTITION BY NULL ORDER BY COUNT(*) DESC) AS rn
	FROM
		film
	GROUP BY
		title, 
		description,
		release_year,
		rating,
		last_update,
		special_features,
		fulltext
)
SELECT
	title, 
	description,
	release_year,
	rating,
	last_update,
	special_features,
	fulltext
FROM 
	mode_counts
WHERE 
	rn = 1;