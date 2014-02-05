/* Question 1
   For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings
   given to that movie. Sort by rating spread from highest to lowest, then by movie title. */

  SELECT a.title, b.ratingSpread
    FROM Movie AS a
    JOIN (SELECT mID, MAX(stars) - MIN(stars) AS ratingSpread
          FROM Rating
          GROUP BY mID) AS b
      ON a.mID = b.mID
ORDER BY b.ratingSpread DESC, a.title
