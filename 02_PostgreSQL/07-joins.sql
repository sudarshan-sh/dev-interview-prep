-- =========================================
-- JOINS: INNER, LEFT, RIGHT, FULL, SELF
-- =========================================
-- runs inside the sdb database, reuses the courses / batches / students /
-- student_batches tables + sample data created in 06-nested-queries.sql

-- 1. INNER JOIN - only rows that match in both tables
-- students along with the batch they are enrolled in
SELECT s.name, sb.batchid, sb.joiningdate
FROM students s
INNER JOIN student_batches sb ON sb.rollno = s.rollno;

-- 2. LEFT JOIN - all rows from the left table, matched rows from the right
--    (unmatched right-side columns come back NULL)
-- every student, even the ones not enrolled in any batch
SELECT s.name, sb.batchid
FROM students s
LEFT JOIN student_batches sb ON sb.rollno = s.rollno;

-- 3. RIGHT JOIN - all rows from the right table, matched rows from the left
-- every batch, even the ones with no students enrolled yet
SELECT b.batchid, s.name
FROM student_batches sb
RIGHT JOIN batches b ON b.batchid = sb.batchid
LEFT JOIN students s ON s.rollno = sb.rollno;

-- 4. FULL OUTER JOIN - all rows from both sides, NULLs where there's no match
-- every student-batch pairing, including students with no batch
-- and batches with no students
SELECT s.name, sb.batchid
FROM students s
FULL OUTER JOIN student_batches sb ON sb.rollno = s.rollno;

-- 5. multi-table JOIN
-- student name, the course they're enrolled in, and the batch start date
SELECT s.name, c.coursename, b.start_date
FROM students s
JOIN student_batches sb ON sb.rollno = s.rollno
JOIN batches b ON b.batchid = sb.batchid
JOIN courses c ON c.courseid = b.courseid;

-- 6. SELF JOIN - a table joined to itself
-- students who joined the same batch as each other (excluding pairing with themselves)
SELECT s1.name AS student1, s2.name AS student2, sb1.batchid
FROM student_batches sb1
JOIN student_batches sb2
    ON sb1.batchid = sb2.batchid AND sb1.rollno < sb2.rollno
JOIN students s1 ON s1.rollno = sb1.rollno
JOIN students s2 ON s2.rollno = sb2.rollno;
