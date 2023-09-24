SELECT
	A.name,
	SUM(F.amount) AS total_revenue,
	COUNT(DISTINCT B.film_id) AS film_count
FROM category A
	INNER JOIN film_category B ON A.category_id = B.category_id
	INNER JOIN film C ON B.film_id = C.film_id
	INNER JOIN inventory D ON C.film_id = D.film_id
	INNER JOIN rental E ON D.inventory_id = E.inventory_id
	INNER JOIN payment F ON E.rental_id = F.rental_id
GROUP BY 
	A.name
ORDER BY 
	total_revenue DESC;
