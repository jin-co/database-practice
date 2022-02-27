SELECT * FROM teacher;
SELECT * FROM student;
SELECT * FROM class;
SELECT * FROM student_class_link;

SELECT DISTINCT teacherID, COUNT(teacherID) FROM teacher GROUP BY teacherID;

SELECT DISTINCT classID, COUNT(*) FROM class GROUP BY classID;

SELECT DISTINCT program, studentNo, COUNT(*) FROM student GROUP BY program, studentNo;

SELECT DISTINCT t.teacherID, c.classID, s.program, s.studentNo, COUNT(DISTINCT t.teacherID) 
FROM class c
JOIN teacher t ON (c.teacherID = t.teacherID)
JOIN student_class_link scl ON (c.classID = scl.classID)
JOIN student s ON (scl.studentNo = s.studentNo)
GROUP BY t.teacherID, c.classID, s.program, s.studentNo;