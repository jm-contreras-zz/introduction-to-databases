/* Question 1
   Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and
   grades. Sort by grade, then by name within each grade. */
   
  SELECT Name, Grade
    FROM Highschooler
   WHERE ID NOT IN (SELECT ID1
                      FROM Likes) AND ID NOT IN (SELECT ID2
                                                   FROM Likes)
ORDER BY Grade, Name

/* Question 2
   For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can
   introduce them!). For all such trios, return the name and grade of A, B, and C. */

SELECT d.Name, d.Grade, e.Name, e.Grade, f.Name, f.Grade
  FROM Likes AS a, Friend AS b, Friend AS c, Highschooler AS d, Highschooler AS e, Highschooler AS f
 WHERE a.ID1 = b.ID1 AND a.ID2 = c.ID1 AND b.ID2 = c.ID2 AND a.ID1 = d.ID AND a.ID2 = e.ID AND b.ID2 = f.ID AND
       a.ID2 NOT IN (SELECT ID2
                       FROM Friend
                      WHERE ID1 = a.ID1)

/* Question 3
   Find the difference between the number of students in the school and the number of different first names. */
   
SELECT COUNT(name) - COUNT(DISTINCT(name))
  FROM Highschooler
  
/* Question 4
   What is the average number of friends per student? (Your result should be just one number.) */
   
SELECT AVG(n_friend)
  FROM (  SELECT COUNT(ID2) AS n_friend
            FROM Friend
        GROUP BY ID1)

/* Question 5
   Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count
   Cassandra, even though technically she is a friend of a friend. */

SELECT COUNT(DISTINCT(a.ID1)) + COUNT(DISTINCT(b.ID2)) - 1
  FROM Friend AS a, Friend AS b
 WHERE a.ID1 = b.ID1 AND a.ID2 = (SELECT ID
                                    FROM Highschooler
                                   WHERE Name = 'Cassandra')

/* Question 6
   Find the name and grade of the student(s) with the greatest number of friends. */
   
SELECT Name, Grade
  FROM (  SELECT ID1, COUNT(*) AS n_friend
            FROM Friend
        GROUP BY ID1) AS a
  JOIN Highschooler AS b
    ON a.ID1 = b.ID
 WHERE n_friend = (SELECT MAX(c.n_friend)
                     FROM (  SELECT ID1, COUNT(*) AS n_friend
                               FROM Friend
                           GROUP BY ID1) c)
