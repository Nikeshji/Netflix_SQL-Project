SELECT * FROM netflix;

SELECT
      COUNT(*) as total_content

FROM netflix;

---Problem 

 1-Count the no of movies and tv show 

 SELECT 
 		type
		 COUNT(*) as  total_content 

FROM netflix
GROUP BY type 

 2-Find the most common rating for movies and tv show 

SELECT
     type,
	 rating
	  
FROM 
(    
SELECT
     type
	 rating
	 COUNT(*)
	 RANK() OVER(PARTITION by type ORDER BY COUNT(*))DECS) as ranking
FROM neflix
GROUP BY 1,2

) as t1
WHERE
    ranking=1


 3-List all movies released in a specific year (e.g,2020)

SELECT * FROM neflix 
WHERE 
     type='movie'
	 AND 
	 realesed_ year = 2020

 4-Find the top 5 countries with the most content on netflix 

SELECT
     UNNEST(STRING_TO_ARRAY(country," ")) as new_country
	 COUNT(show_id) as total_content

FROM netflix
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 5


 5-Identity the longest movie

SELECT * FROM netflix 
WHERE
     type ='movie'
	 AND 
	 duration = (SELECT MAX (duration) FROM netflix)


 6-Find content added in the last 5 year

SELECT
     *

FROM netflix
WHERE
     TO_DATE(date_added,'Month DD, YYYY')>=CURRENT_DATE-INTERVAL'5 year'


 7-Find all the movie/Tv show by director 'Rajiv chhilaka'


 SELECT * FROM netflix
 WHERE director ILIKE 'Rajiv chilaka'


 8-List all tv show with more than 5 seasons

 SELECT
      *
	  FROM netflix 
	  WHERE 
	  type = 'tv show'
	  AND 
	  SPLIT_PART(duration.' ',1) :: numeric>5

 SELECT_PART('Apple Banana Cherry',' ',1)


 9-Count the no of content items in each genre


SELECT
      UNNEST(STRING_TO_ARRAY(listed_in,' '))as genre,
	  COUNT(show_id) as total_content
FROM netflix
GROUP BY 1


 10-Find each year and the overage no of content release by india on netflix. release top 5 year with highest avg content release 


SELECT
     EXTRACT(YEAR FROM TO_DATE(date_added,'month DD<YYYY'),
	 COUNT(*)as yearly_content,
	 ROUND
	 COUNT(*)::numeric/(SELECT COUNT(*) FROM netflix WHERE='india')::numeric*100,2)as avg-content_per_year

FROM netflix
WHERE country ='india'
GROUP BY 1



 11-List all movie movies that are documentaries 

SELECT * FROM netflix
WHERE
     listed_in ILIKE '%documentaries%'



 12-Find all content without a director

 SELECT * FROM netflix 
 WHERE
 director is null

 13-Find how many movies actor 'salman khan' appeared in last 10 year!

 SELECT * FROM netflix 
 WHERE
     cast ILIKE '%salman khan%'
	 AND
	 release_year>EXTRACT(YEAR FROM CURRENT_DATE) -10


 14-Find the top 10  actors who have appeared in the highest no of movies produced in india

 SELECT
 UNNEST(STRING_TO_ARRAY(cast,' ') as actors,
 COUNT(*) as total_content 
 FROM netflix
 WHERE country ILIKE '%india%'
 GROUP BY 1
 ORDER BY 2 DESC 
 LIMIT 10
 
	 