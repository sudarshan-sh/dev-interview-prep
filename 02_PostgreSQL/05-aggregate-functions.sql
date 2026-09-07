-- =========================================
-- AGGREGATE FUNCTIONS: COUNT, SUM, AVG, MIN, MAX
-- =========================================
-- (these run against the employee table created in 02-tables.sql)

-- 1. find or count employee having age > 40
SELECT COUNT(*) from employee WHERE age > 40;

-- 2. count employees using DISTINCT names
SELECT COUNT(DISTINCT name) from employee;

-- 3. find the sum of salaries having salary greater than 70000
SELECT SUM(salary) from employee WHERE salary > 70000;

-- 4. find average of the salaries having salary greater than 70000
SELECT AVG(salary) from employee WHERE salary > 70000;