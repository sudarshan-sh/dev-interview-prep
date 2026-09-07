-- =========================================
-- PRACTICE: SQL Series - UPDATE and DELETE
-- =========================================

-- Schema:
-- Employee
--   - empid   int      primary key
--   - name    varchar
--   - age     int
--   - salary  float

-- Queries:
-- 1. Update Employee salary by 10% where employee age is above 38.
UPDATE employee SET salary=salary * 1.1 WHERE age > 38;
-- 2. Update all the Employee ages to 25 if it has a NULL value.
UPDATE employee SET age=25 WHERE age is NULL;
-- 3. Delete all the records of Employee table where age is below 18.
DELETE FROM employee WHERE age < 18;
-- 4. Delete all Employee records where salary ranges from 50000 to 60000.
DELETE FROM employee WHERE salary BETWEEN 50000 AND 60000;
-- 5. Update all the Employees salary by 20% where name begins with letter 'S'.
UPDATE employee SET salary=salary * 1.2 WHERE name ILIKE 's%';
