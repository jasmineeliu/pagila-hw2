/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */
SELECT title 
FROM film
WHERE film_id IN (
    SELECT DISTINCT film_id
    FROM film,
    UNNEST(film.special_features) AS features
    WHERE features = 'Trailers'
) AND
film.rating = 'G'
ORDER BY title;

