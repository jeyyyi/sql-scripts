# Join and Multiple Tables

CREATE database exerciseMultTable2;
USE exerciseMultTable2;
SHOW tables;

CREATE TABLE STUDENT
	(StudNo INTEGER NOT NULL PRIMARY KEY,
    Sname VARCHAR(15),
    Course VARCHAR(20),
    DateAdmitted DATE,
    StudAddress VARCHAR(20));
    
SELECT * FROM STUDENT;
SELECT * FROM STUDSUBJECT;

CREATE TABLE STUDSUBJECT
	(StudNo INTEGER NOT NULL,
    SubjectCode VARCHAR(15) NOT NULL,
    Grade DECIMAL(5,2),
    SchoolYearSem VARCHAR(20),
    PRIMARY KEY (StudNo, SubjectCode),
    CONSTRAINT StudNoFK FOREIGN KEY(StudNo)
    REFERENCES STUDENT(StudNo)
    );

INSERT INTO STUDENT
	VALUES (1001, 'Paje', 'CS', '2012-06-26', 'Quezon City'),
	       (1002, 'Rivera', 'IT', '2013-07-03', 'Mandaluyong'),
           (1003, 'Cabas', 'IT', '2016-05-23', 'Manila'),
           (1004, 'Zulueta', 'CoE', '2018-06-18', 'Manila'),
           (1005, 'Caballero', 'CE', '2012-07-12', 'San Juan'),
		   (1006, 'Elenzano', 'ME', '2012-03-25', 'Makati'),
           (1007, 'Cabanilla', 'IT', '2012-03-03', 'Manila'),
           (1008, 'Cayetano', 'IT', '2013-05-25', 'Mandaluyong'),
           (1009, 'Penaflor', 'CoE', '2017-08-25', 'Quezon City'),
           (2000, 'Medrano', 'CS', '2014-07-18', 'Manila'),
           (2001, 'Icalabis', 'IT', '2019-10-04', 'Quezon City'),
           (2002, 'Mangalindan', 'CE', '2018-04-16', 'Manila'),
           (2003, 'Barrientos', 'CS', '2018-10-04', 'Manila'),
           (2004, 'Medenilla', 'IT', '2012-06-04', 'Quezon City'),
           (2005, 'Pandungan', 'ME', '2013-07-04', 'San Juan'),
           (2006, 'Afable', 'CS', '2012-05-23', 'Paranaque');
           
INSERT INTO STUDSUBJECT
	VALUES (1001, 'COMP20093', 1.50, 'AY2020SEM2'),
		   (1003, 'COMP20091', 1.75, 'AY2021SEM1'),
           (1004, 'COMP20093', 1.00, 'AY2021SEM1'),
           (1001, 'COMP20090', 2.50, 'AY2020SEM1'),
           (1001, 'COMP20092', 3.00, 'AY2020SEM2'),
           (1005, 'COMP20093', 2.50, 'AY2021SEM1'),
           (1007, 'COMP20090', 1.75, 'AY2020SEM1'),
           (1009, 'COMP20093', 1.00, 'AY2020SEM1'),
           (2006, 'COMP20092', 2.25, 'AY2021SEM2'),
           (2001, 'COMP20093', 2.75, 'AY2021SEM1'),
	       (2000, 'COMP20091', 1.75, 'AY2020SEM1'),
           (2005, 'COMP20091', 2.50, 'AY2021SEM1'),
           (2001, 'COMP20091', 1.50, 'AY2020SEM2'),
           (2006, 'COMP20093', 1.00, 'AY2021SEM1'),
           (1005, 'COMP20091', 2.25, 'AY2020SEM1'),
           (1008, 'COMP20093', 1.00, 'AY2021SEM2'),
           (1006, 'COMP20092', 1.50, 'AY2020SEM1'),
           (1009, 'COMP20091', 2.50, 'AY2021SEM1');
           
-- Display the student no. of all students who live in manila 
-- (address has a manila in it) who are either enrolled
-- or have taken up subject (code) COMP20093 
SELECT S.StudNo 
FROM STUDENT S 
JOIN STUDSUBJECT SS ON S.StudNo = SS.StudNo
WHERE ((StudAddress LIKE '%manila%') AND (SubjectCode = 'COMP20093'));
            
-- Display all student names who got a grade of 1.0 in COMP20093
SELECT S.Sname 
FROM STUDENT S 
JOIN STUDSUBJECT SS	ON S.StudNo = SS.StudNo
WHERE ((Grade = 1.0) AND (SubjectCode = 'COMP20093'));

-- Display all student information from STUDENT table for those 
-- who are not enrolled in any subject for school year and sem ‘AY2021SEM1’
SELECT * FROM STUDENT 
WHERE StudNo NOT IN
(SELECT StudNo FROM STUDSUBJECT
WHERE SchoolYearSem = 'AY2021SEM1');

-- Who are the IT students who got an average grade of 1.0 to 1.75. Display the student no. only
SELECT StudNo FROM STUDENT 
WHERE (Course = 'IT')
AND StudNo IN 
	(SELECT StudNo 
    FROM STUDSUBJECT 
    GROUP BY StudNo
    HAVING AVG(Grade) BETWEEN 1.0 AND 1.75);

-- Display all student numbers who are admitted during year 2012 
-- and who are enrolled (in any subject) during school year /sem ‘AY2021SEM1’
SELECT StudNo 
	FROM STUDENT
	WHERE (DateAdmitted LIKE '%2012%')
	AND StudNo IN 
		(SELECT StudNo
			FROM STUDSUBJECT 
			WHERE (SchoolYearSem = 'AY2021SEM1'));

-- Display the student no. and the average grade for each CS student for AY2021SEM1
SELECT S.StudNo, S.Sname, SS.Grade
FROM STUDENT S JOIN STUDSUBJECT SS
ON S.StudNo = SS.StudNo
WHERE ((Course = 'CS') AND (SchoolYearSem = 'AY2021SEM1'))
GROUP BY StudNo
HAVING AVG(Grade);

SELECT S.StudNo, Grade
FROM STUDENT S JOIN STUDSUBJECT SS
	ON S.StudNo = SS.StudNo
WHERE (Course = 'CS') AND SchoolYearSem = 'AY2021SEM1'
GROUP BY S.StudNo
HAVING AVG(Grade);