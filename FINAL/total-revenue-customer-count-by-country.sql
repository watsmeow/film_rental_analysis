SELECT 	
	D.country,
	COUNT(DISTINCT A.customer_id) AS count_of_customer,
	SUM(F.amount) AS total_revenue
FROM customer A
	INNER JOIN address B ON A.address_id = B.address_id
	INNER JOIN city C ON B.city_id = C.city_id
	INNER JOIN country D ON C.country_id = D.country_id
	INNER JOIN rental E ON A.customer_id = E.customer_id
	INNER JOIN payment F ON E.rental_id = F.rental_id
GROUP BY 
	D.country
ORDER BY 
	count_of_customer DESC, 
	total_revenue DESC