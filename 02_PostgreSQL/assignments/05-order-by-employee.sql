-- =========================================
-- PRACTICE: SQL Series - ORDER BY
-- =========================================

-- Schema:
-- Employee
--   - empid   int      primary key
--   - name    varchar
--   - age     int
--   - salary  float

-- Queries:
-- 1. Select all the employees from Employee table where age is in 20s and populate
--    records in ascending order of salaries.
SELECT * from employee WHERE age BETWEEN 20 AND 29 ORDER BY salary ASC;

-- 2. Select all records of Employee table arranged in descending order of employee names.
SELECT * from employee ORDER BY name DESC;

-- 3. Select all employees from Employee table where age is above 25 years arranged in
--    ascending order of names and if name collides then arrange in descending order
--    of salaries.
SELECT * from employee WHERE age > 25 ORDER BY name ASC, salary DESC;

-- 4. Select only employee names and salaries from Employee table and arranged in
--    ascending order of their ages.
SELECT name, salary from employee ORDER BY age ASC;

-- 5. Select employee records from Employee table where second letter of employee name
--    is 'a' and result arranged in descending order of their salaries.
SELECT * from employee WHERE name ILIKE '_a%' ORDER BY salary DESC;
