USE itcpa;
-- student
DROP TABLE IF EXISTS student;
CREATE TABLE student (
	studentId INT(30) PRIMARY KEY AUTO_INCREMENT,
    studentFirstName VARCHAR(50) NOT NULL,
    studentLastName VARCHAR(50) NOT NULL,
    studentEmail VARCHAR(50) NOT NULL,
    studentNumber VARCHAR(50) NOT NULL,
    hasTeam BOOL DEFAULT false
);

INSERT INTO student VALUES 
(DEFAULT, 'tom', 'jack', 'tom@com.net', '#202022', DEFAULT),
(DEFAULT, 'what', 'jack', 'what@com.net', '#202021', DEFAULT),
(DEFAULT, 'well', 'jack', 'weel@com.net', '#202022', DEFAULT);

-- term
DROP TABLE IF EXISTS school_term;
CREATE TABLE school_term (
	school_term_id INT(30) PRIMARY KEY AUTO_INCREMENT,
    school_term_name VARCHAR(15) NOT NULL
);

SELECT * FROM student;
show tables;