WITH title_count AS (SELECT COUNT(r.rental_id) AS rental_count,
		f.title AS title,
		f.film_id AS id,
		c.name AS category,
		c.category_id AS category_id,
		ci.city AS city,
		ci.city_id AS city_id
FROM rental AS r
JOIN inventory AS i ON i.inventory_id = r.inventory_id
JOIN film AS f ON f.film_id = i.film_id
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
JOIN customer AS cus ON r.customer_id = cus.customer_id
JOIN address AS ad ON cus.address_id = ad.address_id
JOIN city AS ci ON ci.city_id = ad.city_id
GROUP BY 2, 3, 4, 5, 6, 7)

SELECT title_count.id,
	title_count.title,
	title_count.category,
	title_count.category_id,
	title_count.rental_count,
	ROW_NUMBER() OVER (ORDER BY title_count.rental_count DESC) AS "rank",
	title_count.city,
	title_count.city_id
	FROM title_count
	ORDER BY rank
	
SELECT co.country_id, co.country, ci.city_id, ci.city, cus.customer_id
FROM country AS co
JOIN city AS ci
ON co.country_id = ci.country_id
JOIN address AS a
ON a.city_id = ci.city_id
JOIN customer AS cus
ON cus.address_id = a.address_id
ORDER BY 1,2,3,4
 ////
 
SELECT COUNT(r.rental_id) AS rental_count, c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name
FROM rental AS r
JOIN customer AS c
ON c.customer_id = r.customer_id
JOIN address AS ad
ON ad.address_id = c.address_id
JOIN city AS ci
ON ad.city_id = ci.city_id
JOIN country AS co
ON ci.country_id = co.country_id
GROUP BY 2, 3
ORDER BY 1 DESC

SELECT r.rental_id, c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name, ci.city_id, ci.city, co.country_id, co.country
FROM rental AS r
JOIN customer AS c
ON c.customer_id = r.customer_id
JOIN address AS ad
ON ad.address_id = c.address_id
JOIN city AS ci
ON ad.city_id = ci.city_id
JOIN country AS co
ON ci.country_id = co.country_id
WHERE co.country = 'Brazil' OR country = 'United States'
ORDER BY 2
///

SELECT pay.amount AS rental_sum, 
	Date_part('month', r.rental_date) AS Rental_month,
    Date_part('year', r.rental_date)  AS Rental_year
FROM payment AS pay
JOIN rental AS r
ON pay.rental_id = r.rental_id
WHERE Date_part('year', r.rental_date) = '2005'

SELECT pay.amount AS rental_sum, 
	Date_part('month', r.rental_date) AS Rental_month,
    Date_part('year', r.rental_date)  AS Rental_year,
	ci.city_id,
	ci.city,
	co.country_id,
    co.country
FROM payment AS pay
JOIN rental AS r ON pay.rental_id = r.rental_id
JOIN customer AS c ON r.customer_id = c.customer_id
JOIN address AS ad ON c.address_id = ad.address_id
JOIN city AS ci ON ad.city_id = ci.city_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE Date_part('year', r.rental_date) = '2005' AND co.country = 'Brazil' OR country = 'United States'

SELECT SUM(pay.amount) AS rental_sum, 
    ci.city,
	ci.city_id
FROM payment AS pay
JOIN rental AS r ON pay.rental_id = r.rental_id
JOIN customer AS c ON r.customer_id = c.customer_id
JOIN address AS ad ON c.address_id = ad.address_id
JOIN city AS ci ON ad.city_id = ci.city_id
WHERE Date_part('year', r.rental_date) = '2005'
GROUP BY 2, 3
ORDER BY 1 DESC

SELECT name FROM category

//

SELECT r.rental_id, r.rental_date, pay.payment_id, pay.amount, co.country_id, co.country, cus.customer_id, CONCAT(cus.first_name, ' ', cus.last_name) AS full_name, f.film_id
FROM film AS f
JOIN inventory ON f.film_id = inventory.film_id
JOIN rental AS r ON inventory.inventory_id = r.inventory_id
JOIN payment AS pay ON pay.rental_id = r.rental_id
JOIN customer AS cus ON pay.customer_id = cus.customer_id
JOIN address ON address.address_id = cus.address_id
JOIN city ON city.city_id = address.city_id
JOIN country AS co ON co.country_id = city.country_id
WHERE co.country = 'Brazil' OR co.country = 'United States' OR co.country = 'China'

SELECT f.film_id, f.title, f.replacement_cost, f.rating, cat.category_id, cat.name, r.rental_id, r.rental_date, pay.payment_id, pay.amount
FROM category AS cat
JOIN film_category ON cat.category_id = film_category.category_id
JOIN film AS f ON film_category.film_id = f.film_id
JOIN inventory ON inventory.film_id = f.film_id
JOIN rental AS r ON inventory.inventory_id = r.inventory_id
JOIN payment AS pay ON pay.rental_id = r.rental_id

SELECT cus.customer_id, CONCAT(cus.first_name, ' ', cus.last_name) AS full_name, ci.city_id, ci.city, co.country_id, co.country
FROM customer AS cus
JOIN address ON address.address_id = cus.address_id
JOIN city AS ci ON address.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE co.country = 'Brazil' OR co.country = 'United States' OR co.country = 'China'
