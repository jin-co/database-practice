/*
SELECT * FROM class;
SELECT * FROM student;
SELECT * FROM student_class_link;
SELECT * FROM teacher;
*/

CREATE VIEW vw_Num_Of_Student AS
select c.name as Class_Name, count(scl.studentno) as NumberOfStudents 
from class c inner join student_class_link scl 
on c.ClassID = scl.classID 
group by c.name;


/*
CREATE VIEW Bill_BillPayment
AS  
SELECT Bills.*
FROM Bills INNER JOIN Bill_Payments  
ON Bills.bill_payment_id = Bill_Payments.bill_payment_id;

*/