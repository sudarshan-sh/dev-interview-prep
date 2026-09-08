-- =========================================
-- PRACTICE: Nested Queries (Subqueries) - common interview questions
-- =========================================
-- (uses the courses / batches / students / student_batches schema
--  from ../06-nested-queries.sql, in the sdb database)

-- Schema:
-- courses          (courseid PK, coursename, duration_in_months)
-- batches          (batchid PK, courseid FK -> courses, start_date, time, days, size)
-- students         (rollno PK, name, email, mobile)
-- student_batches  (id PK, rollno FK -> students, batchid FK -> batches, joiningdate)

-- Queries:

-- 1. Find all students who are NOT enrolled in any batch.
SELECT * from students WHERE rollno NOT IN (
    SELECT DISTINCT rollno from student_batches
);

-- 2. Find all courses that currently have no batches scheduled.
SELECT * from courses WHERE courseid NOT IN (
    SELECT DISTINCT courseid from batches
);

-- 3. Find the course(s) with the largest batch size offered.
SELECT * from courses cs WHERE cs.courseid IN (
    SELECT courseid from batches b1 WHERE b1.size = (
        SELECT MAX(b2.size) from batches b2
    )
);

-- OR --
SELECT
    (SELECT coursename FROM courses WHERE courseid = b1.courseid) AS coursename,
    b1.size
FROM batches b1
WHERE b1.size = (
    SELECT MAX(b2.size) FROM batches b2
);


-- 4. Find all batches whose size is greater than the average batch size (across all batches).
SELECT batchid, courseid, start_date, size from batches b1 WHERE size > (
    SELECT AVG(size) from batches
);

-- 5. Find the names of students enrolled in the same batch as 'Aman Verma'.
SELECT name from students WHERE rollno IN (
    SELECT rollno from student_batches WHERE batchid IN (
        SELECT batchid from student_batches WHERE rollno = (
            SELECT rollno from students where name='Aman Verma'
        )
    )
) AND name!='Aman Verma';
-- excludes 'Aman Verma' from the list

-- 6. Find students who are enrolled in more than one batch.

-- 7. Find the batch(es) with the earliest start_date, for each course.

-- 8. Find course names for courses whose every batch has size greater than 20.

-- 9. Find students who have NOT enrolled in any batch of the
--    'Full Stack Web Development' course.

-- =========================================
-- More practice (Employee schema)
-- =========================================

-- Schema:
-- Employee
--   - empid   int      primary key
--   - name    varchar
--   - age     int
--   - salary  float

-- 10. Select all employee records from Employee table where salary is greater than the average salary.
SELECT * from employee WHERE salary > (
    SELECT AVG(salary) from employee
);

-- 11. Find selected oldest employee record from Employee table.
SELECT * from employee WHERE age = (
    SELECT MAX(age) from employee
);

-- 12. Find second lowest salary from Employee table.
SELECT DISTINCT(salary) from employee
ORDER BY salary ASC
OFFSET 1 LIMIT 1;
-- OR --
SELECT MIN(salary) FROM employee
WHERE salary > (SELECT MIN(salary) FROM employee);

-- 13. Find all the employee records whose age is above average age and salary is below average salary of employees.
SELECT * from employee WHERE age > (
    SELECT AVG(age) from employee
) AND salary < (
    SELECT AVG(salary) from employee
);

-- 14. Find third maximum salary from the Employee table.
SELECT DISTINCT(salary) from employee
ORDER BY salary DESC
OFFSET 2 LIMIT 1;