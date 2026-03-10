/*
 * Management is planning on purchasing new inventory.
 * Films with special features cost more to purchase than films without special features,
 * and so management wants to know if the addition of special features impacts revenue from movies.
 *
 * Write a query that for each special_feature, calculates the total profit of all movies rented with that special feature.
 *
 * HINT:
 * Start with the query you created in pagila-hw1 problem 16, but add the special_features column to the output.
 * Use this query as a subquery in a select statement similar to answer to the previous problem.
 */
SELECT features as "special_feature", SUM(payment.amount) as "profit"
FROM film
JOIN (
SELECT film_id, features
FROM film, UNNEST(special_features) AS features
) as film_features USING (film_id)
JOIN inventory ON inventory.film_id=film.film_id
JOIN rental ON inventory.inventory_id=rental.inventory_id
JOIN payment ON rental.rental_id=payment.rental_id
GROUP BY features
ORDER BY special_feature;
