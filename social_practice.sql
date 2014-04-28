/* Question 1
   For every situation where student A likes student B, but we have no information about whom B likes (that is, B does       not appear as an ID1 in the Likes table), return A and B's names and grades. */

SELECT a.Name, a.Grade, b.Name, b.Grade
  FROM Likes, Highschooler AS a, Highschooler AS b
 WHERE ID1 = a.ID AND ID2 = b.ID AND ID2 NOT IN (SELECT ID1
                                                   FROM Likes)

/* Question 2
   For every situation where student A likes student B, but student B likes a different student C, return the names and      grades of A, B, and C. */

SELECT c.Name, c.Grade, d.Name, d.Grade, e.Name, e.Grade
  FROM Likes AS a, Likes AS b, Highschooler AS c, Highschooler AS d, Highschooler AS e
 WHERE a.ID2 = b.ID1 AND a.ID1 != b.ID2 AND a.ID1 = c.ID AND a.ID2 = d.ID AND b.ID2 = e.ID
 
 /* Question 3
    Find those students for whom all of their friends are in different grades from themselves. Return the students'           names and grades. */ 

SELECT Name, Grade
  FROM Highschooler
 WHERE ID NOT IN (SELECT DISTINCT(ID1)
                    FROM Friend, Highschooler AS a, Highschooler AS b
                   WHERE ID1 = a.ID AND ID2 = b.ID AND a.Grade = b.Grade)
