CREATE SCHEMA college_db;

USE college_db;

CREATE TABLE student (
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    grade INT NOT NULL DEFAULT 0
);

INSERT INTO student VALUES(
	DEFAULT,
	'Kwangjin',
    'Baek',
    90
);

SELECT * FROM student;