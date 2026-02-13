-- Netflix Project

DROP TABLE IF EXISTS Netflix;

CREATE TABLE Netflix
(
  show_id VARCHAR(6),
  type    VARCHAR(10),
  title   VARCHAR(110),
  director  VARCHAR(210),
  casts    VARCHAR(800),
  country  VARCHAR(130),
  date_added  VARCHAR(50),
  release_year INT,
  rating	VARCHAR(10),
  duration  VARCHAR(15),
  listed_in   VARCHAR(85), -- (genre)
  description  VARCHAR(260)
);

SELECT * FROM Netflix;

SELECT
    COUNT(*) as total_content
FROM Netflix;

SELECT 
     DISTINCT type
FROM Netflix;

SELECT * FROM Netflix

-- 15 Business Problems and Solutions

-- 1 Count the number of movies vs tv shows

 SELECT 
     type,
	 COUNT(*) as total_content
FROM Netflix
GROUP BY type


-- 2 Find the most common rating for movies and tv shows

SELECT 
   type,
   rating

FROM 
(
SELECT 
    type,
	rating,
	COUNT(*),
	RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC)  as ranking
FROM Netflix
GROUP BY 1,2
) as t1
WHERE 
    ranking = 1


-- 3 List all the movies released in a specific year(eg 2020)	

SELECT * FROM Netflix
WHERE 
   type = 'Movie'
   AND
   release_year = 2020


-- 4 Find the top 5 countries with the most content on netflix

SELECT 
   UNNEST(STRING_TO_ARRAY (country, ',')) as new_country,
   COUNT(show_id) as total_content
 FROM Netflix
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 5


 -- 5 identify the longest movie

 SELECT * FROM Netflix
 WHERE 
     type = 'Movie'
	 AND 
	 duration = (SELECT MAX(duration) FROM Netflix)


-- 6 Find content added in the last 5 years

SELECT
  *
  FROM netflix
  WHERE
    TO_DATE(date_added, 'Month DD YYYY') >= CURRENT_DATE - INTERVAL '5 years'

-- 7 Find all the movies/tv shows by director 'Rajiv Chilaka';

SELECT * FROM Netflix
WHERE director LIKE '%Rajiv Chilaka%'

-- 8 List all tv shows with more than 5 seasons

SELECT
   *
   FROM netflix
   WHERE 
       type = 'TV Show'
	   AND
	   SPLIT_PART(duration,' ', 1):: numeric >5

 -- 9 Count the no of content items in each genre

 SELECT 
     UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
	 COUNT(show_id) as total_content
FROM netflix
GROUP BY 1


 -- 10 FInd the top 10 actors who have appered in  the highest number of movies produced in India

 SELECT
 UNNEST(STRING_TO_ARRAY(casts,',')) as actors,
 COUNT(*) as total_content
 FROM Netflix
 WHERE Country ILIKE '%India'
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 10
 
	
   