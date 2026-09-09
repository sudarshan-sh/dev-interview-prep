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
