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
