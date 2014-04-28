/* Question 1
   Find the names of all reviewers who rated Gone with the Wind. */

SELECT name
  FROM Reviewer
 WHERE rID
    IN (SELECT rID
          FROM Rating
         WHERE mID = (SELECT mID
                        FROM Movie
                       WHERE title = 'Gone with the Wind'))

/* Question 2
   For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and
   number of stars. */

SELECT a.name, c.title, b.stars
  FROM Reviewer AS a
  JOIN Rating AS b
    ON a.rID = b.rID
  JOIN Movie AS c
    ON b.mID = c.mID
 WHERE a.name = c.director
 
 /* Question 3
    Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the
    reviewer and first word in the title is fine; no need for special processing on last names or removing "The".) */ 

SELECT title
  FROM Movie
 UNION
SELECT name
  FROM Reviewer

/* Question 4
   Find the titles of all movies not reviewed by Chris Jackson. */

SELECT title
  FROM Movie
 WHERE mID NOT IN
       (SELECT mID
          FROM Rating
         WHERE rID = (SELECT rID
                        FROM Reviewer
                       WHERE name = 'Chris Jackson'))

/* Question 5
   For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both
   reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, 
   return the names in the pair in alphabetical order. */

  SELECT c.name, d.name
    FROM Rating AS a
    JOIN Rating AS b
      ON a.mID = b.mID
    JOIN Reviewer AS c
      ON a.rID = c.rID
    JOIN Reviewer AS d
      ON b.rID = d.rID
   WHERE a.mID = b.mID AND a.rID != b.rID AND ((SELECT name
                                                  FROM Reviewer
                                                 WHERE a.rID = rID) < (SELECT name
                                                                         FROM Reviewer 
                                                                        WHERE b.rID = rID))
GROUP BY c.name

/* Question 6
   For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and
   number of stars. */ 

SELECT a.name, c.title, b.stars
  FROM Reviewer AS a
  JOIN Rating AS b
    ON a.rID = b.rID
  JOIN Movie AS c
    ON b.mID = c.mID
 WHERE b.stars = (SELECT MIN(stars)
                    FROM Rating)
