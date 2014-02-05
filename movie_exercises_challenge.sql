/* Question 1
   For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings
   given to that movie. Sort by rating spread from highest to lowest, then by movie title. */

  SELECT a.title, b.ratingSpread
    FROM Movie AS a
    JOIN (  SELECT mID, MAX(stars) - MIN(stars) AS ratingSpread
              FROM Rating
          GROUP BY mID) AS b
      ON a.mID = b.mID
ORDER BY b.ratingSpread DESC, a.title

/* Question 2
   Find the difference between the average rating of movies released before 1980 and the average rating of movies
   released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages
   for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.) */

SELECT (SELECT AVG(avgStars) AS avgStarsPrior80
          FROM (  SELECT mID, AVG(stars) AS avgStars
                    FROM Rating
                   WHERE mID IN (SELECT mID
                                   FROM Movie
                                  WHERE year < 1980)
                GROUP BY mID)) -
       (SELECT AVG(avgStars) AS avgStarsAfter80
          FROM (  SELECT mID, AVG(stars) AS avgStars
                    FROM Rating
                   WHERE mID IN (SELECT mID
                                   FROM Movie
                                  WHERE year > 1980)
                GROUP BY mID))

/* Question 3
   Some directors directed more than one movie. For all such directors, return the titles of all movies directed by
   them, along with the director name. Sort by director name, then movie title. */

  SELECT title, director
    FROM Movie
   WHERE director IN (SELECT director
                        FROM (  SELECT director, COUNT(title) AS nMovie
                                  FROM Movie
                              GROUP BY director)
                       WHERE nMOVIE > 1)
ORDER BY director, title

/* Question 4
   Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is
   more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and
   then choosing the movie(s) with that average rating.) */

SELECT b.title, a.avgStars
  FROM (  SELECT mID, AVG(stars) AS avgStars
            FROM Rating
        GROUP BY mID) AS a
  JOIN (SELECT mID, title
          FROM Movie) AS b
    ON a.mID = b.mID
 WHERE avgStars = (SELECT MAX(avgStars) AS maxStars
                     FROM (  SELECT mID, AVG(stars) AS avgStars
                               FROM Rating
                           GROUP BY mID))

/* Question 5
   Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query is
   more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and
   then choosing the movie(s) with that average rating.) */

SELECT b.title, a.avgStars
  FROM (  SELECT mID, AVG(stars) AS avgStars
            FROM Rating
        GROUP BY mID) AS a
  JOIN (SELECT mID, title
          FROM Movie) AS b
    ON a.mID = b.mID
 WHERE avgStars = (SELECT MIN(avgStars) AS maxStars
                     FROM (  SELECT mID, AVG(stars) AS avgStars
                               FROM Rating
                           GROUP BY mID))

/* Question 6
   For each director, return the director's name together with the title(s) of the movie(s) they directed that received
   the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL. */

  SELECT a.director, a.title, MAX(b.stars)
    FROM Movie AS a
    JOIN Rating AS b
      ON a.mID = b.mID
   WHERE a.director IS NOT NULL
GROUP BY a.director
