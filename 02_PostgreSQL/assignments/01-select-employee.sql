-- =========================================
-- PRACTICE: SQL Series - SELECT
-- =========================================

-- Schema:
-- Employee
--   - empid   int      primary key
--   - name    varchar
--   - age     int
--   - salary  float

-- Queries:
-- 1. Select all rows and all columns of the Employee table.
SELECT * from employee;

-- 2. Select all records of the Employee table where age is less than 30.
SELECT * from employee WHERE age < 30;

-- 3. Select all records of the Employee table where salary ranges between 18000 to 25000.
SELECT * from employee WHERE salary BETWEEN 18000 AND 25000;

-- 4. Select all records of the Employee table where name ends with character 'h'.
SELECT * from employee WHERE name ILIKE '%h';

-- 5. Select all records of the Employee table where name of the employee can be
--    'Sandeep' or 'Ruchi' or 'Aditya'.
SELECT * from employee WHERE name IN ('Sandeep', 'Ruchi', 'Aditya');
