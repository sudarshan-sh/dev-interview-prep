-- =========================================
-- PRACTICE: GROUP BY & HAVING
-- =========================================
-- (uses the courses / batches / students / student_batches schema
--  from ../06-nested-queries.sql, in the sdb database)

-- Schema:
-- courses          (courseid PK, coursename, duration_in_months)
-- batches          (batchid PK, courseid FK -> courses, start_date, time, days, size)
-- students         (rollno PK, name, email, mobile)
-- student_batches  (id PK, rollno FK -> students, batchid FK -> batches, joiningdate)

-- Queries:

-- 1. List students who are enrolled in more than one batch, using a JOIN instead of a subquery.
SELECT s.rollno, s.name, COUNT(sb.batchid) AS enrolled_batches
FROM students s
INNER JOIN student_batches sb ON sb.rollno = s.rollno
GROUP BY s.rollno, s.name
HAVING COUNT(sb.batchid) > 1;

-- 2. List course names that have more than one batch scheduled.
SELECT c.coursename, COUNT(b.batchid) AS batch_count
FROM courses c
INNER JOIN batches b ON b.courseid = c.courseid
GROUP BY c.courseid, c.coursename
HAVING COUNT(b.batchid) > 1;

-- 3. What is the total number of student enrollments course-wise?
SELECT COUNT(sb.batchid), c.coursename from students s
INNER JOIN student_batches sb ON sb.rollno = s.rollno
INNER JOIN batches b ON b.batchid = sb.batchid
INNER JOIN courses c ON c.courseid = b.courseid
GROUP BY c.coursename;

-- 4. What is the total student seating capacity offered course-wise?
SELECT c.coursename, SUM(b.size) AS total_capacity FROM batches b
INNER JOIN courses c ON c.courseid = b.courseid
GROUP BY c.coursename;

-- 5. Which courses are highly popular and have generated more than 2 enrollments?
SELECT c.coursename, COUNT(sb.rollno) AS total_enrolments from student_batches sb
INNER JOIN batches b ON b.batchid = sb.batchid
INNER JOIN courses c ON c.courseid = b.courseid
GROUP BY c.coursename
HAVING COUNT(sb.rollno) > 2;

-- 6. Which specific batches have exceeded a safety threshold of more than 2 student enrollments, and what are those batch IDs?
SELECT sb.batchid, COUNT(sb.rollno) AS total_enrolments from student_batches sb
GROUP BY sb.batchid
HAVING COUNT(sb.rollno) > 2;
