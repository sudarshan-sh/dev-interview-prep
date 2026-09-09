-- =========================================
-- GROUP BY & HAVING
-- =========================================
-- runs inside the sdb database, reuses the courses / batches / students /
-- student_batches tables + sample data created in 06-nested-queries.sql

-- 1. GROUP BY - collapse rows into groups, one row per group
-- number of batches per course
SELECT courseid, COUNT(*) AS batch_count
FROM batches
GROUP BY courseid;

-- 2. GROUP BY with a JOIN - grouping on a column pulled in from another table
-- number of batches per course, showing the course name instead of just the id
SELECT c.coursename, COUNT(b.batchid) AS batch_count
FROM courses c
LEFT JOIN batches b ON b.courseid = c.courseid
GROUP BY c.coursename;

-- 3. WHERE vs HAVING
-- WHERE filters rows before grouping; HAVING filters groups after aggregation
-- (WHERE can't reference an aggregate like COUNT/AVG - that's what HAVING is for)

-- only batches on 'Mon-Fri' (row filter), grouped by course
SELECT c.coursename, COUNT(b.batchid) AS batch_count
FROM courses c
JOIN batches b ON b.courseid = c.courseid
WHERE b.days = 'Mon-Fri'
GROUP BY c.coursename;

-- only courses with more than one batch (group filter)
SELECT c.coursename, COUNT(b.batchid) AS batch_count
FROM courses c
JOIN batches b ON b.courseid = c.courseid
GROUP BY c.coursename
HAVING COUNT(b.batchid) > 1;

-- 4. WHERE + HAVING together - filter rows first, then filter the resulting groups
-- among 'Mon-Fri' batches, courses offering more than one of them
SELECT c.coursename, COUNT(b.batchid) AS batch_count
FROM courses c
JOIN batches b ON b.courseid = c.courseid
WHERE b.days = 'Mon-Fri'
GROUP BY c.coursename
HAVING COUNT(b.batchid) > 1;

-- 5. GROUP BY multiple columns
-- number of students who joined each batch, per joining date
SELECT batchid, joiningdate, COUNT(*) AS students_joined
FROM student_batches
GROUP BY batchid, joiningdate;

-- 6. students enrolled in more than one batch (HAVING on a many-to-many link table)
SELECT s.rollno, s.name, COUNT(sb.batchid) AS enrolled_batches
FROM students s
JOIN student_batches sb ON sb.rollno = s.rollno
GROUP BY s.rollno, s.name
HAVING COUNT(sb.batchid) > 1;
