-- =========================================
-- PRACTICE: SQL Series - Wild Cards
-- =========================================

-- Schema:
-- Employee
--   - empid   int      primary key
--   - name    varchar
--   - age     int
--   - salary  float

-- Queries:

-- 1. Select all employee records from Employee table where name contained 'sh'.
SELECT * from employee WHERE name ILIKE '%sh%';

-- 2. Select all employee records from Employee table where name ends at 'sh'.
SELECT * from employee WHERE name ILIKE '%sh';

-- 3. Select all employee records from Employee table where name has exactly two letters before 'n'.
SELECT * from employee WHERE name ILIKE '__n%';

-- 4. Select all employee records from Employee table where name has exactly 5 letters.
SELECT * from employee WHERE name LIKE '_____';
-- 5 underscores
-- OR --
SELECT * from employee WHERE LENGTH(name)=5;

-- 5. Select all the records from Employee table where names having first letter either A or N.
SELECT * from employee WHERE name ILIKE 'a%' OR name ILIKE 'n%';
