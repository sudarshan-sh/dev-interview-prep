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
SELECT c.courseid, c.coursename, COUNT(b.batchid) AS total_batches from courses c
LEFT JOIN batches b ON b.courseid = c.courseid
GROUP BY c.courseid, c.coursename ORDER BY total_batches DESC;

-- 8. List students who are NOT enrolled in any batch, using a JOIN instead of a subquery.
SELECT s.rollno, s.name from students s
LEFT JOIN student_batches sb ON sb.rollno=s.rollno WHERE sb.rollno IS NULL;

-- =========================================
-- More practice (SQL Join)
-- =========================================

-- 9. Find all the batchid which belong to the course with coursename 'Data Science'.
SELECT b.batchid, c.coursename from batches b
INNER JOIN courses c ON c.courseid = b.courseid
WHERE c.coursename = 'Data Science';

-- 10. Select rollno of students who are enrolled in the batches of the 'Data Science' course.
SELECT sb.rollno, c.coursename from student_batches sb
INNER JOIN batches b ON b.batchid = sb.batchid
INNER JOIN courses c ON c.courseid = b.courseid
WHERE c.coursename = 'Data Science';


-- 11. Populate the joining dates of all the students along with their rollno,
--     for batches of the 'Data Science' course.
SELECT sb.rollno, s.name, c.coursename, sb.joiningdate from students s
INNER JOIN student_batches sb ON sb.rollno = s.rollno
INNER JOIN batches b ON b.batchid = sb.batchid
INNER JOIN courses c ON c.courseid = b.courseid
WHERE c.coursename = 'Data Science';

-- 12. Select student rollno, name and joining date of all the students enrolled in batch 101.
SELECT sb.rollno, s.name, sb.joiningdate from students s
INNER JOIN student_batches sb ON sb.rollno = s.rollno
WHERE sb.batchid = 101;

-- 13. Select all the student names, batchid and course names, of students who have taken admission in any batch.
SELECT s.name, c.coursename, sb.batchid from students s
INNER JOIN student_batches sb ON sb.rollno = s.rollno
INNER JOIN batches b ON b.batchid = sb.batchid
INNER JOIN courses c ON c.courseid = b.courseid;