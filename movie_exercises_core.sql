/* Question 1
   Find the titles of all movies directed by Steven Spielberg. */

SELECT title
  FROM movie
 WHERE director = 'Steven Spielberg'

/* Question 2
   Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. */

  SELECT DISTINCT(year)
    FROM Movie AS a
    JOIN (SELECT mID
            FROM Rating
           WHERE stars > 3) AS b
      ON a.mID = b.mID
ORDER BY year

/* Question 3
   Find the titles of all movies that have no ratings. */

SELECT title
  FROM Movie
 WHERE mID NOT IN (SELECT mID
                     FROM Rating)

/* Question 4
Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date. */

SELECT name
  FROM Reviewer
 WHERE rID IN (SELECT rID
                 FROM Rating
                WHERE ratingDate IS NULL)

/* Question 5
Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. */

  SELECT name, title, stars, ratingDate
    FROM (SELECT a.name, b.stars, b.ratingDate, b.mID
            FROM Reviewer AS a
            JOIN Rating AS b
              ON a.rID = b.rID) AS c
    JOIN Movie AS d
      ON c.mID = d.mID
ORDER BY name, title, stars

/* Question 6
For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie. */

/* Question 7
For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title. */

  SELECT a.title, b.maxStars
    FROM Movie AS a
    JOIN (  SELECT mID, MAX(stars) AS maxStars
              FROM Rating
          GROUP BY mID) AS b
      ON a.mID = b.mID
ORDER BY a.title

/* Question 8
List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order. */

  SELECT a.title, b.avgStars
    FROM Movie AS a
    JOIN (  SELECT mID, AVG(stars) AS avgStars
              FROM Rating
          GROUP BY mID) AS b
      ON a.mID = b.mID
ORDER BY b.avgStars DESC, a.title

/* Question 9
Find the names of all reviewers who have contributed three or more ratings. */

SELECT a.name
  FROM Reviewer AS a
  JOIN (SELECT rID
          FROM (  SELECT rID, COUNT(stars) AS countStars
                    FROM Rating
                GROUP BY rID) AS c
         WHERE c.countStars > 2) AS b
    ON a.rID = b.rID
