
-- student
DROP TABLE IF EXISTS student;
CREATE TABLE student (
	student_id INT(30) PRIMARY KEY AUTO_INCREMENT,
    student_first_name VARCHAR(50) NOT NULL,
    student_last_name VARCHAR(50) NOT NULL,
    student_email VARCHAR(50) NOT NULL,
    student_number VARCHAR(50) NOT NULL
);

INSERT INTO student VALUES (
	DEFAULT, 'tom', 'jack', '#202020'
);

-- term
DROP TABLE IF EXISTS school_term;
CREATE TABLE school_term (
	school_term_id INT(30) PRIMARY KEY AUTO_INCREMENT,
    school_term_name VARCHAR(15) NOT NULL
);

SELECT * FROM student;
show tables;