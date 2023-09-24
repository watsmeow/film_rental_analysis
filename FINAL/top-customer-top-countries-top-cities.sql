WITH top_ten_country_cte AS (
	SELECT 
		D.country_id,
		D.country,
		COUNT(A.customer_id) AS count_of_customer
	FROM customer A
		INNER JOIN address B ON A.address_id = B.address_id
		INNER JOIN city C ON B.city_id = C.city_id
		INNER JOIN country D ON C.country_id = D.country_id
	GROUP BY 
		D.country_id,
		D.country
	ORDER BY count_of_customer DESC
	LIMIT 10
),
top_ten_cities_cte AS 
(
SELECT 	
	C.city,
	C.city_id,
	D.country,
	D.country_id,
	COUNT(DISTINCT A.customer_id) AS count_of_customer,
	SUM(F.amount) AS total_revenue
FROM customer A
	INNER JOIN address B ON A.address_id = B.address_id
	INNER JOIN city C ON B.city_id = C.city_id
	INNER JOIN top_ten_country_cte D ON C.country_id = D.country_id
	INNER JOIN rental E ON A.customer_id = E.customer_id
	INNER JOIN payment F ON E.rental_id = F.rental_id
GROUP BY 
	C.city,
	C.city_id,
	D.country,
	D.country_id
ORDER BY 
	count_of_customer DESC, 
	total_revenue DESC
LIMIT 10
)
SELECT 
	A.customer_id,
	A.first_name,
	A.last_name, 
	C.city,
	F.country,
	SUM(E.amount) AS total_paid
FROM customer A
	INNER JOIN address B ON A.address_id = B.address_id
	INNER JOIN top_ten_cities_cte C ON B.city_id = C.city_id
	INNER JOIN rental D ON A.customer_id = D.customer_id
	INNER JOIN payment E ON D.rental_id = E.rental_id
	INNER JOIN country F ON C.country_id = F.country_id
GROUP BY 
	A.customer_id,
	A.first_name,
	A.last_name, 
	C.city,
	F.country
ORDER BY  
	total_paid DESC
LIMIT 10