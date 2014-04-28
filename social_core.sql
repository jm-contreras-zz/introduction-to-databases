/* Question 1
   Find the names of all students who are friends with someone named Gabriel. */

SELECT name
FROM Highschooler
WHERE ID IN (SELECT ID1
             FROM Friend
             WHERE ID2 IN (SELECT ID
                           FROM Highschooler
                           WHERE name = 'Gabriel'))

/* Question 2
   For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade,     and the name and grade of the student they like. */

SELECT a.Name, a.Grade, b.Name, b.Grade
  FROM Highschooler AS a, Highschooler AS b, Likes
 WHERE a.ID = ID1 AND b.ID = ID2 AND a.Grade >= b.Grade + 2

/* Question 3
   For every pair of students who both like each other, return the name and grade of both students. Include each pair      only once, with the two names in alphabetical order. */

SELECT c.Name, c.Grade, d.Name, d.Grade
  FROM Likes AS a, Likes AS b, Highschooler AS c, Highschooler AS d
 WHERE a.ID1 = b.ID2 AND a.ID2 = b.ID1 AND a.ID1 = c.ID AND a.ID2 = d.ID AND c.Name < d.Name

/* Question 4
   Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by    name within each grade.  */

  SELECT Name, Grade
    FROM Highschooler
   WHERE ID NOT IN (SELECT ID1 
	  			      FROM Friend, Highschooler AS b, Highschooler AS c
			         WHERE ID1 = b.ID AND ID2 = c.ID AND b.grade != c.grade)
ORDER BY Grade, Name

/* Question 5 
   Find the name and grade of all students who are liked by more than one other student. */

SELECT Name, Grade
  FROM Highschooler
 WHERE ID in (SELECT a.ID2
				FROM (  SELECT ID2, COUNT(ID2) AS count
						  FROM Likes
					  GROUP BY ID2) AS a
			   WHERE a.count > 1)
