/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
SELECT "rank", title, "revenue",
SUM (revenue) OVER (ORDER BY revenue DESC) as "total revenue",
to_char(100*SUM (revenue) OVER (ORDER BY revenue DESC)/SUM (revenue) OVER (), 'FM999900.00') as "percent revenue"
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

