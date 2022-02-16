select * from teacher
select * from class
select * from student
select * from student_class_link

SELECT c.name, count(c.section) NumberOfSections 
from CLASS c
GROUP BY c.name


select <fieldName1>,.....<fieldnameN>,Count(<fieldName>)
from <tableName>
group by <fieldName1>,.....<fieldnameN>

Count, Sum, Avg,

--write a query to dispay how many classes do each teacher teaches

select * from teacher
select * from class

select t.name as TeacherName, count(c.ClassID) as CountOfClasses  from teacher t
left join  class c
on t.TeacherID = c.teacherID
group by t.name