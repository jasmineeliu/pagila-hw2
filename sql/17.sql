/*
 * Compute the total revenue for each film.
 * The output should include another new column "total revenue" that shows the sum of all the revenue of all previous films.
 *
 * HINT:
 * My solution starts with the solution to problem 16 as a subquery.
 * Then I combine the SUM function with the OVER keyword to create a window function that computes the total.
 * You might find the following stackoverflow answer useful for figuring out the syntax:
 * <https://stackoverflow.com/a/5700744>.
 */
SELECT "rank", title, "revenue", 
SUM (revenue) OVER (ORDER BY revenue DESC) as "total revenue"
FROM (
SELECT
 RANK() OVER (ORDER BY COALESCE(SUM(amount), 0.00) DESC) AS "rank",
 title,
 COALESCE(SUM(amount), 0.00) as "revenue"
FROM film
LEFT JOIN (
SELECT * FROM inventory
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
) as revenues USING (film_id)
GROUP BY title
) as rankings
ORDER BY "revenue" DESC, title;

