use ig_clone;

-- WITH total_photos AS(
-- SELECT
-- 	user_id,
--     COUNT(*) as total_photos
-- FROM
-- 	photos
-- GROUP BY
-- 	user_id)
-- avg_photos AS(
-- 	SELECT
-- 		AVG(total_photos) as avg_photos
-- 	FROM
-- 		total_photos
--         )
-- SELECT
-- 	id,
--     username
-- FROM
-- 	users
-- WHERE
-- 	id IN
--     (SELECT
-- 		user_id,
--         COUNT(*) AS total
-- 	FROM
-- 		photos
-- 	GROUP BY
-- 		user_id
-- 	HAVING
-- 		total > (SELECT
-- 					avg_photos
-- 				 FROM
-- 					avg_photos);

SELECT
	ROUND(AVG(total_count),2) as total_avg
FROM
	(
		SELECT
			user_id,
			COUNT(*) as total_count
		FROM
			photos
		GROUP BY
			user_id
	) as T1;
    
SELECT
	user_id,
    COUNT(*) as total_photos
FROM
	photos
GROUP BY
	user_id
HAVING
	total_photos > ( SELECT
							ROUND(AVG(total_count),2) as total_avg
					  FROM
							(
								SELECT
									user_id,
									COUNT(*) as total_count
								FROM
									photos
								GROUP BY
									user_id
							) as T1 );



WITH total_photos AS
		(  SELECT
				user_id,
                COUNT(*) AS total_photos
			FROM
				photos
			GROUP BY
				user_id
		),
	total_avg AS
		(
			SELECT
				ROUND(AVG(total_photos),2) as total_avg
			FROM
				total_photos
		)
SELECT
	id,
    username,
    total_photos
FROM
	users as U
LEFT JOIN
	total_photos AS t
ON
   u.id = t.user_id
WHERE
	id IN
		(SELECT
			 user_id
		 FROM
			 total_photos
		 WHERE
			 total_photos > (SELECT
								total_avg
							FROM
								total_avg));


	
	
				