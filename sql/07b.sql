/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT film.title
FROM film
LEFT JOIN (
SELECT film_id, country FROM
inventory
JOIN rental USING (inventory_id)
JOIN customer USING (customer_id)
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id)
WHERE country.country = 'United States'
) as US_RENTALS USING (film_id)
WHERE film.film_id IN (
    SELECT film_id FROM inventory WHERE film_id IS NOT NULL
) AND
US_RENTALS IS NULL
ORDER BY title;
