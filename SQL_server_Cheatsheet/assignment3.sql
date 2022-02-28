SELECT * FROM teacher;
SELECT * FROM student;
SELECT * FROM class;
SELECT * FROM student_class_link;

SELECT DISTINCT teacherID, COUNT(teacherID) FROM teacher GROUP BY teacherID;

SELECT DISTINCT classID, COUNT(*) FROM class GROUP BY classID;

SELECT DISTINCT program, studentNo, COUNT(*) FROM student GROUP BY program, studentNo;

CREATE VIEW vw_total_count_of_classes AS
	SELECT t.teacherID, 
		COUNT(DISTINCT t.teacherID) AS "teacher_count", 
		c.classID,
		COUNT(DISTINCT c.classID) AS "class_count", 
		s.studentNo,
		s.program,
		COUNT(DISTINCT s.studentNo) AS "student_count"
	FROM class c
		JOIN teacher t ON (c.teacherID = t.teacherID)
		JOIN student_class_link scl ON (c.classID = scl.classID)
		JOIN student s ON (scl.studentNo = s.studentNo)
	GROUP BY t.teacherID, c.classID, s.studentNo, s.program;