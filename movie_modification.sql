/* Question 1
   Add the reviewer Roger Ebert to your database, with an rID of 209. */ 

INSERT INTO Reviewer
     VALUES (209, 'Roger Ebert')

/* Question 2
   Insert 5-star ratings by James Cameron for all movies in the database. Leave the review date as NULL. */

INSERT INTO Rating
     SELECT a.rID, b.mID, 5, NULL
       FROM Reviewer AS a
       JOIN Movie AS b
      WHERE a.name = 'James Cameron'

/* Question 3
   For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing
   tuples; don't insert new tuples.) */



/* Question 4
   Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars. */

DELETE FROM Rating
      WHERE stars < 4 AND mID IN (SELECT mID
                                    FROM Movie
                                   WHERE year NOT BETWEEN 1970 AND 2000)
