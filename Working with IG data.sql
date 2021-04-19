-- Challenges
USE ig_clone;

-- CHALLENGE 1
-- Find the 5 oldest users

SELECT
	username,
    created_at
FROM 	
	users
ORDER BY 
	created_at
LIMIT 5;

-- -----------------------------------------------------------------------

-- CHALLENGE 2
-- What day of the week do most users register on?

SELECT
	DAYNAME(created_at) AS Weekday,
    COUNT(*) AS users_registered
FROM
	users
GROUP BY
	1
ORDER BY
	2 DESC;
    
-- -----------------------------------------------------------------------

-- CHALLENGE 3
-- Find the users who have never posted a photo

SELECT
	username
FROM
	users
LEFT JOIN
	photos
ON
	users.id = photos.user_id
WHERE 
	user_id IS NULL;
    
-- -----------------------------------------------------------------------

-- CHALLENGE 4
-- Who has the most likes in a single photo

SELECT
	username,
	photos.id,
    image_url,
    COUNT(*) AS LIKES
FROM
	photos
JOIN
	likes
ON
	photos.id = likes.photo_id
JOIN
	users
ON
	photos.user_id = users.id
GROUP BY
	photos.id
ORDER BY
	4 DESC
LIMIT 1;

-- -----------------------------------------------------------------------

-- CHALLENGE 5
-- How many times does the average user post
-- average no of photos per user
-- total nu,ber of photots / total number of users

SELECT
	(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS Average;

-- SELECT
-- 	avg(TOTAL)
-- FROM
-- 	(SELECT
-- 		user_id,
-- 		COUNT(id) AS TOTAL
--      FROM
-- 		photos
--     GROUP BY
-- 		user_id
-- 	) as TEMP;


-- CHALLENGE 6
-- What are the top 5 most commonly used hashtags?

SELECT
	tag_name,
    COUNT(photo_id) AS TOTAL_USED
FROM
	tags 
JOIN 
	photo_tags
ON
	tags.id = tag_id
GROUP BY
	tag_id
ORDER BY
	2 DESC
LIMIT 5;

-- CHALLENGE 7
-- Find the users who have liked every single photo on the site
-- (bots)
SELECT
	username,
    COUNT(*) AS num_likes
FROM
	users
JOIN
	likes
ON
	users.id = likes.user_id
GROUP BY
	likes.user_id
HAVING
	num_likes = (SELECT COUNT(*) FROM photos);

