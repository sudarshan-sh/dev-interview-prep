-- =========================================
-- PRACTICE: SQL Series - AGGREGATE FUNCTIONS
-- =========================================

-- Schema:
-- Employee
--   - empid   int      primary key
--   - name    varchar
--   - age     int
--   - salary  float

-- Queries:

-- 1. Select minimum salary from the Employee table.
SELECT MIN(salary) FROM EMPLOYEE;

-- 2. Select max age from the Employee table.
SELECT MAX(age) FROM EMPLOYEE;

-- 3. Count the number of records in Employee table.
SELECT COUNT(*) FROM EMPLOYEE;

-- 4. Calculate the sum of salaries of all the employees.
SELECT SUM(salary) FROM EMPLOYEE;

-- 5. Calculate the average of salaries of all the employees whose age is not NULL and name contains 'ni'.
SELECT AVG(salary) FROM Employee
WHERE age IS NOT NULL AND name ILIKE '%ni%';
