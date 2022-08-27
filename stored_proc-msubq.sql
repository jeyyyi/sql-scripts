# stored procedure and multiple subqueries

create database stored_proc_multi_table;
use stored_proc_multi_table;

ALTER TABLE SUBJECTS
add constraint sub_fk1 FOREIGN KEY (StudentID)
REFERENCES Student(StudentID),
add constraint sub_fk2 FOREIGN KEY (SubjectCode)
REFERENCES Course (SubjectCode);

select * FROM course;
select * FROM student;
select * FROM subjects;

-- Count the total number of enrollees per course for a particular sem (input sem).  
-- One student is one count regardless of the number of subjects enrolled.  
-- Display the course and the count in descending order of the count.
call SPnum1('%S1');
call SPnum1('%S2');

SELECT Count(DISTINCT ST.studentid) AS Count, ST.course
		FROM subjects SU JOIN student ST ON SU.studentid = ST.studentid
        WHERE SU.aysem LIKE '%S2'
		GROUP BY ST.course
		ORDER BY Count(*) DESC;

-- Input allowed tenure  (or number of years allowed to stay in school).  List down the student id, name, course, contact # of all who have exceeded the allowed tenure
-- must not have value in year graduated
-- the number of years in residence is computed by the current year minus the year admitted. Year admitted is the first 4 characters of the student id 

CALL SPnum2(3);

    select * from course;
    select * from student;
    select * from subjects;

	SELECT StudentID, StudentName, Course, ContactNo,
    CAST(LEFT(StudentID, 4) AS UNSIGNED) as 'YEAR ADMITTED',
    CAST(YEAR(curdate()) AS UNSIGNED) - CAST(LEFT(StudentID, 4) AS UNSIGNED) AS 'Years of Residence'
    FROM Student
    WHERE YearGraduated = 0 
    AND CAST(YEAR(curdate()) AS UNSIGNED) - CAST(LEFT(StudentID, 4) AS UNSIGNED) > 5;
    
-- For a particular schoolyear/sem  and course  (input schoolyear-sem, course), 
-- list down the Dean’s listers, those with average grade 1.5 and above.  Display the student id  and name.

call SPnum3 ('2018-2019S1', 'BSCS');

-- Display the  candidates for latin honors for a particular course.  Input course.  Display student id, and name. The criteria are as follows
-- must not have a grade of 5.
-- must not have a grade lower than 1.75
-- tenure must not exceed the allowed 5 years

call SPnum4 ('BSCS');
call SPnum4 ('BSIT');

-- Display the  candidates for latin honors with the top 2 highest average grades for a particular course.  Input course.  Display student id and average grade only.
-- must not have a grade of 5.
-- must not have a grade lower than 1.75

call SPnum5 ('BSCS');
call SPnum5 ('BSIT');