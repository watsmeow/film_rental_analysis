SELECT
	B.title,
	H.name AS language,
	G.name as category,
	AVG(B.rental_duration) AS avg_rental_duration,
	SUM(F.amount) AS total_revenue
FROM film B
	INNER JOIN language H on B.language_id = H.language_id
	INNER JOIN film_category A ON B.film_id = A.film_id
	INNER JOIN category G ON A.category_id = G.category_id
	INNER JOIN inventory D ON D.film_id = B.film_id
	INNER JOIN rental E ON D.inventory_id = E.inventory_id
	INNER JOIN payment F ON E.rental_id = F.rental_id
GROUP BY 
	B.title,
	G.name,
	H.name
ORDER BY 
	avg_rental_duration,
	total_revenue DESC
LIMIT 10;
