/*
 * Compute the total revenue for each film.
 */
SELECT title, COALESCE(SUM(amount), 0.00) as "revenue"
FROM film
LEFT JOIN (
SELECT * FROM inventory
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
) as revenues USING (film_id) 
GROUP BY title
ORDER BY "revenue" DESC, title;

