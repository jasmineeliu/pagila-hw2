/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */
SELECT title 
FROM (
    SELECT title FROM film, UNNEST(special_features) AS features
    WHERE features = 'Behind the Scenes'
) as bts 
JOIN 
(
    SELECT title FROM film, UNNEST(special_features) AS features
    WHERE features = 'Trailers'
) as trailers
USING (title)
ORDER BY title
;
