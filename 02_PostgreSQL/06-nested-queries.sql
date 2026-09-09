-- =========================================
-- NESTED QUERIES (SUBQUERIES)
-- =========================================
-- runs inside the sdb database
-- connect: docker exec -it myDb psql -U sudarshan -d sdb

-- =========================================
-- SETUP: tables
-- =========================================

-- 1. courses table
CREATE TABLE courses (
    courseid            int PRIMARY KEY,
    coursename          varchar(100),
    duration_in_months  int
);

-- 2. batches table (each batch belongs to a course)
CREATE TABLE batches (
    batchid    int PRIMARY KEY,
    courseid   int,
    start_date DATE,
    time       TIME,
    days       varchar(20),
    size       int,
    CONSTRAINT FK_course_batch
        FOREIGN KEY (courseid) REFERENCES courses (courseid)
);

-- 3. students table
CREATE TABLE students (
    rollno int PRIMARY KEY,
    name   varchar(100),
    email  varchar(100),
    mobile varchar(15)
);

-- 4. student_batches table (students enrolled into a batch)
CREATE TABLE student_batches (
    id          int PRIMARY KEY,
    rollno      int,
    batchid     int,
    joiningdate DATE,
    CONSTRAINT FK_student_batch
        FOREIGN KEY (rollno) REFERENCES students (rollno),
    CONSTRAINT FK_batch_student
        FOREIGN KEY (batchid) REFERENCES batches (batchid)
);

-- =========================================
-- SETUP: sample data
-- =========================================

-- 1. courses
INSERT INTO courses (courseid, coursename, duration_in_months)
VALUES
    (1, 'Full Stack Web Development', 6),
    (2, 'Data Science',               8),
    (3, 'Digital Marketing',          4),
    (4, 'UI/UX Design',               3);

-- 2. batches
INSERT INTO batches (batchid, courseid, start_date, time, days, size)
VALUES
    (101, 1, '2026-01-05', '10:00:00', 'Mon-Fri', 30),
    (102, 1, '2026-03-01', '18:00:00', 'Sat-Sun', 25),
    (103, 2, '2026-02-10', '09:00:00', 'Mon-Fri', 20),
    (104, 3, '2026-01-15', '19:00:00', 'Sat-Sun', 40);

-- 3. students
INSERT INTO students (rollno, name, email, mobile)
VALUES
    (1, 'Aman Verma',   'aman.verma@example.com',   '9876543210'),
    (2, 'Priya Singh',  'priya.singh@example.com',  '9876543211'),
    (3, 'Rohit Sharma', 'rohit.sharma@example.com', '9876543212'),
    (4, 'Neha Gupta',   'neha.gupta@example.com',   '9876543213'),
    (5, 'Karan Mehta',  'karan.mehta@example.com',  '9876543214');

-- 4. student_batches
INSERT INTO student_batches (id, rollno, batchid, joiningdate)
VALUES
    (1, 1, 101, '2026-01-05'),
    (2, 2, 101, '2026-01-06'),
    (3, 3, 102, '2026-03-01'),
    (4, 4, 103, '2026-02-10'),
    (5, 1, 104, '2026-01-15');

-- 5. add 'standard' to students - independent of batch, since students in the
--    same batch can be preparing for different exams/standards
ALTER TABLE students ADD COLUMN standard varchar(10);

UPDATE students SET standard = CASE rollno
    WHEN 1 THEN '3rd'
    WHEN 2 THEN '2nd'
    WHEN 3 THEN '4th'
    WHEN 4 THEN '3rd'
    WHEN 5 THEN '5th'
END;

-- =========================================
-- QUESTIONS
-- =========================================

-- 1. Populate names and emails from students table where the rollno of students exists in the student_batches table where the batchid=101;
SELECT name, email from students WHERE rollno IN (SELECT rollno from student_batches WHERE batchid=101);

-- 2. (from db1)
-- Select all the employees from the employee table whose salaries are above than the average salaries of the employees in the same department;
SELECT * from employee e1 WHERE salary > (
    SELECT AVG(salary) from employee e2
    WHERE e1.dept = e2.dept
);