-- =========================================
-- PRACTICE: JOINS - common interview questions
-- =========================================
-- (uses the courses / batches / students / student_batches schema
--  from ../06-nested-queries.sql, in the sdb database)

-- Schema:
-- courses          (courseid PK, coursename, duration_in_months)
-- batches          (batchid PK, courseid FK -> courses, start_date, time, days, size)
-- students         (rollno PK, name, email, mobile)
-- student_batches  (id PK, rollno FK -> students, batchid FK -> batches, joiningdate)

-- Queries:

-- 1. List all students along with the batch id they are enrolled in.
SELECT s.name, sb.batchid from students s
INNER JOIN student_batches sb ON sb.rollno=s.rollno;

-- 2. List all students, including those not enrolled in any batch.
SELECT s.name, sb.batchid from students s
LEFT JOIN student_batches sb ON sb.rollno=s.rollno;

-- 3. List all batches, including those with no students enrolled yet.
SELECT b.batchid, s.name FROM student_batches sb
RIGHT JOIN batches b ON b.batchid = sb.batchid
LEFT JOIN students s ON s.rollno = sb.rollno;

-- 4. List every student-batch pairing, including unmatched students and
--    unmatched batches on either side.
SELECT s.name, sb.batchid FROM students s
FULL OUTER JOIN student_batches sb ON sb.rollno = s.rollno;

-- 5. List student name, course name, and batch start date together.
SELECT 
    s.name AS student_name,
    c.coursename AS course_name,
    b.start_date AS batch_start_date
FROM students s
INNER JOIN student_batches sb ON sb.rollno = s.rollno
INNER JOIN batches b ON b.batchid = sb.batchid
INNER JOIN courses c ON c.courseid = b.courseid;

-- 6. List pairs of students who are enrolled in the same batch as each other.
----- CASE OF SELF JOIN -----
SELECT sb1.batchid, s1.name, s2.name from student_batches sb1
INNER JOIN student_batches sb2 ON sb2.batchid = sb1.batchid AND sb1.rollno < sb2.rollno
INNER JOIN students s1 ON s1.rollno = sb1.rollno
INNER JOIN students s2 ON s2.rollno = sb2.rollno;

-- 7. List each course along with the number of batches offered for it.

-- 8. List students who are NOT enrolled in any batch, using a JOIN instead of a subquery.
