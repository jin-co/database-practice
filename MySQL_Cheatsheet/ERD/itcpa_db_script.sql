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
	schoolTermId INT(30) PRIMARY KEY AUTO_INCREMENT,
    schoolTermName VARCHAR(15) NOT NULL
);

-- team request
DROP TABLE IF EXISTS team_request;
CREATE TABLE team_request (
	teamRequestId INT(30) PRIMARY KEY AUTO_INCREMENT,
    senderId INT(30) NOT NULL,
    receiverId INT(30) NOT NULL,
    sentDate DATETIME DEFAULT NOW(),
    accepted BOOL DEFAULT FALSE
);
INSERT INTO team_request VALUES (
	DEFAULT, 2, 1, DEFAULT, DEFAULT
);

-- project
DROP TABLE IF EXISTS project;
CREATE TABLE project (
	projectId INT(30) PRIMARY KEY AUTO_INCREMENT,
    companyName VARCHAR(50) NOT NULL,
    companyEmail VARCHAR(70) NOT NULL,
    companyPhone VARCHAR(20) NOT NULL,
    projectName VARCHAR(20) NOT NULL,
    projectDescription VARCHAR(100) NOT NULL,
    targetProgram VARCHAR(10) NOT NULL,
    attachedFile VARCHAR(5)
);

INSERT INTO project VALUES 
(DEFAULT, 'TOM COM', 'TOM@COM.COM', '010-010', 'TOM PROJECT', 'GOOD', 'CPA', NULL);


SELECT * FROM team_request;
show tables;