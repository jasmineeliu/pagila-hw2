/*
 * Compute the total revenue for each film.
 * The output should include a new column "rank" that shows the numerical rank
 *
 * HINT:
 * You should use the `rank` window function to complete this task.
 * Window functions are conceptually simple,
 * but have an unfortunately clunky syntax.
 * You can find examples of how to use the `rank` function at
 * <https://www.postgresqltutorial.com/postgresql-window-function/postgresql-rank-function/>.
 */
SELECT 
 RANK() OVER (ORDER BY COALESCE(SUM(amount), 0.00) DESC) AS "rank",
 title, COALESCE(SUM(amount), 0.00) as "revenue"
FROM film
LEFT JOIN (
SELECT * FROM inventory
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
) as revenues USING (film_id)
GROUP BY title
ORDER BY "revenue" DESC, title;
