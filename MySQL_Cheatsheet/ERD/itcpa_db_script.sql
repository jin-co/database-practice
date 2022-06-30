DROP TABLE IF EXISTS student;

CREATE TABLE student (
	student_id INT(30) PRIMARY KEY AUTO_INCREMENT,
    student_first_name VARCHAR(50) NOT NULL,
    student_last_name VARCHAR(50) NOT NULL,
    student_number VARCHAR(50) NOT NULL
)

show tables;