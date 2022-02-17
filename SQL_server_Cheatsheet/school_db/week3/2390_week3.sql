--select 
select * from class where name = 'prog2390'

--union / union all
select name from class where teacherid = 1
union --all
select name from class where teacherid = 2

--insert
insert into teacher(name, education_level, position)
values('Bob Martin', 'MBA', 'Professor')

insert into teacher(name, education_level, position)
select field1, field2, field3 from anotherTable

--delete
delete from student where program = 'itid'

--delete based on records in another table
delete st
from student st
inner join student_class_link scl
on st.studentno = scl.studentno
where scl.classID = 7

delete from student where studentno in
(select studentno from student_class_link where classID = 7)

--create table
CREATE TABLE [dbo].[school](
	[SchoolID] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[city] [varchar](50) NULL,
	[enrollment] [int] NOT NULL,
) 

--drop table
drop table school

--exists (all professors teaching the CAS program
select t.* from teacher t
where  exists
(select * from class c 
inner join student_class_link scl 
	on c.ClassID = scl.classID
inner join student s 
	on s.studentno = scl.studentno
where s.program ='cas' and c.teacherID = t.TeacherID
)

--case
select *,
case
when start_date >= '2021-01-01' and start_date <= '2021-05-30' then 'Winter Semester'
when start_date >= '2021-06-01' and start_date <= '2021-08-30' then 'Spring Semester'
when start_date >= '2021-09-01' and start_date <= '2021-12-30' then 'Fall Semester'
else 'undetermined'
end
semester
from class

--left join (add a teacher to the teacher table who is not teaching a class to demo)
select t.*, c.* from teacher t
left join class c on
t.TeacherID = c.teacherID

--right join ( same as above)
select c.*, t.* from class c
right join teacher t on
t.TeacherID = c.teacherID

--inner join (info for CAS program)
select * from class c 
inner join student_class_link scl 
	on c.ClassID = scl.classID
inner join student s 
	on s.studentno = scl.studentno
where s.program ='cas' 

--cross join
select * from student, class

--view 
create view [dbo].[vw_studentinfo] as 
select t.*,
c.ClassID, c.name as ClassName, c.section, c.start_date,
s.studentno, s.name as StudentName, s.program
from teacher t    
inner join class c 
	on t.TeacherID = c.teacherID
inner join student_class_link scl 
	on c.ClassID = scl.classID
inner join student s 
	on s.studentno = scl.studentno

select * from vw_studentinfo
