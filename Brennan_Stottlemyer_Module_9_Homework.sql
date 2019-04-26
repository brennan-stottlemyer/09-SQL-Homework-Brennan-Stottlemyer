USE sakila;

-- 1a
SELECT first_name, last_name 
FROM actor;

-- 1b
ALTER TABLE actor 
ADD actor_name VARCHAR(30) FIRST;

UPDATE actor
SET actor_name = UPPER(CONCAT(first_name, " ", last_name));

-- 2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "JOE";

-- 2b
SELECT actor_name
FROM actor
WHERE last_name LIKE "%GEN%";

-- 2c
SELECT actor_name
FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;

-- 2d 
SELECT country_id, country
FROM country
WHERE country IN ("Afghanistan","Bangladesh","China");

-- 3a
ALTER TABLE actor 
ADD description BLOB;

-- 3b
ALTER TABLE actor
DROP description;

-- 4a
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;

-- 4b
SELECT last_name, COUNT(last_name) AS count_last_name
FROM actor
GROUP BY last_name
HAVING count_last_name > 1;

-- 4c
UPDATE actor
SET first_name = "HARPO", actor_name = concat(first_name, " ", last_name)
WHERE actor_id = 172;

-- 4d
UPDATE actor
SET first_name = "GROUCHO", actor_name = concat(first_name, " ", last_name)
WHERE actor_id = 172;

-- 5a
SHOW CREATE TABLE address;

-- 6a
SELECT first_name, last_name, address 
FROM staff
JOIN address USING (address_id);

-- 6b
SELECT first_name, last_name, staff_id, SUM(amount) AS total_amount
FROM staff
JOIN payment USING (staff_id)
WHERE payment_date LIKE "2005-05%"
GROUP BY staff_id;

-- 6c
SELECT film_id, title, COUNT(actor_id) AS number_of_actors
FROM film
JOIN film_actor USING (film_id)
GROUP BY film_id;

-- 6d
SELECT title, COUNT(inventory_id) AS inventory_count
FROM inventory
JOIN film USING (film_id) 
WHERE title = "Hunchback Impossible";

-- 6e
SELECT customer_id, first_name, last_name, SUM(amount) AS amount_total
FROM payment
JOIN customer USING (customer_id)
GROUP BY customer_id 
ORDER BY last_name;

-- 7a
SELECT count(title) 
FROM film 
WHERE title LIKE "K%" OR title LIKE "Q%"
	  AND language_id IN 
(
 SELECT language_id
 FROM language
 WHERE name = "English"
 );
    
-- 7b
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN
(
 SELECT actor_id
 FROM film_actor
 WHERE film_id IN
 (
  SELECT film_id
  FROM film
  WHERE title = "Alone Trip"
  )
 );

-- 7c
SELECT first_name, last_name, email, city
FROM customer
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id)
WHERE country = "Canada";

-- 7d
SELECT title, name
FROM film
JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE name = "Family";

-- 7e
SELECT film_id, title, COUNT(rental_date) AS number_of_rentals
FROM rental
JOIN inventory USING (inventory_id)
JOIN film USING (film_id)
GROUP BY film_id
ORDER BY number_of_rentals DESC;

-- 7f
SELECT store_id, SUM(amount)
FROM store
JOIN customer USING (store_id)
JOIN payment USING (customer_id)
GROUP BY store_id;

-- 7g
SELECT store_id, city, country
FROM store
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id);

-- 7h
SELECT name, SUM(amount) as revenue
FROM category 
JOIN film_category USING (category_id)
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
GROUP BY name
ORDER BY revenue DESC
LIMIT 5;

-- 8a 
CREATE VIEW top_5_genres_gross_revenue AS
SELECT name, SUM(amount) as revenue
FROM category 
JOIN film_category USING (category_id)
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
GROUP BY name
ORDER BY revenue DESC
LIMIT 5;

-- 8b
SELECT * FROM top_5_genres_gross_revenue;

-- 8c
DROP VIEW top_5_genres_gross_revenue;
