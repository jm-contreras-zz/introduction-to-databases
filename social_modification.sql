/* Question 1
   It's time for the seniors to graduate. Remove all 12th graders from Highschooler. */ 

DELETE FROM Highschooler
      WHERE Grade = 12

/* Question 2
   If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple. */

DELETE FROM Likes
      WHERE ID1 IN (SELECT ID1
                      FROM Friend
                     WHERE Likes.ID2 = ID2) AND ID1 NOT IN (SELECT b.ID2
                                                              FROM Likes AS b
                                                             WHERE Likes.ID2 = b.ID1)
                                                             
/* Question 3
   For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add
   duplicate friendships, friendships that already exist, or friendships with oneself. */

INSERT INTO Friend
     SELECT f1.ID1, f2.ID2
       FROM Friend f1, Friend f2
      WHERE f1.ID2 = f2.ID1 AND f1.ID1 != f2.ID2
     EXCEPT
     SELECT *
       FROM Friend
