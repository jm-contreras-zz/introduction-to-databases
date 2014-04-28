


  SELECT Name, Grade
    FROM Highschooler
   WHERE ID NOT IN (SELECT ID1
                      FROM Likes) AND ID NOT IN (SELECT ID2
                                                   FROM Likes)
ORDER BY Grade, Name








SELECT d.Name, d.Grade, e.Name, e.Grade, f.Name, f.Grade
  FROM Likes AS a, Friend AS b, Friend AS c, Highschooler AS d, Highschooler AS e, Highschooler AS f
 WHERE a.ID1 = b.ID1 AND a.ID2 = c.ID1 AND b.ID2 = c.ID2 AND a.ID1 = d.ID AND a.ID2 = e.ID AND b.ID2 = f.ID AND
       a.ID2 NOT IN (SELECT ID2
                       FROM Friend
                      WHERE ID1 = a.ID1)


SELECT COUNT(name) - COUNT(DISTINCT(name))
  FROM Highschooler
  

SELECT AVG(n_friend)
  FROM (  SELECT COUNT(ID2) AS n_friend
            FROM Friend
        GROUP BY ID1)


SELECT COUNT(DISTINCT(a.ID1)) + COUNT(DISTINCT(b.ID2)) - 1
  FROM Friend AS a, Friend AS b
 WHERE a.ID1 = b.ID1 AND a.ID2 = (SELECT ID
                                    FROM Highschooler
                                   WHERE Name = 'Cassandra')
