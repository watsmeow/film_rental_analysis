SELECT
	B.title,
	AVG(B.rental_duration) AS avg_rental_duration,
	SUM(F.amount) AS total_revenue
FROM film B
	INNER JOIN inventory D ON D.film_id = B.film_id
	INNER JOIN rental E ON D.inventory_id = E.inventory_id
	INNER JOIN payment F ON E.rental_id = F.rental_id
GROUP BY 
	B.title
ORDER BY 
	total_revenue DESC;
