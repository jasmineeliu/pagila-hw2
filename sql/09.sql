/*
 * Count the number of movies that contain each type of special feature.
 * Order the results alphabetically be the special_feature.
 */
SELECT features as "special_features", count(*)
FROM film, 
UNNEST (film.special_features) AS features 
GROUP BY features 
ORDER BY special_features;
