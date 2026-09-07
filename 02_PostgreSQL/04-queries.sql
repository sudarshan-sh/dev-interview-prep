-- =========================================
-- QUERIES: FILTERING, SORTING, DISTINCT
-- =========================================
-- (these run against the employee table created in 02-tables.sql)

-- matching patterns (LIKE / ILIKE)
SELECT * FROM employee WHERE name ILIKE 'm%';

-- checking ranges and lists (BETWEEN / IN)
SELECT * FROM employee WHERE dept IN ('Sales', 'Technology');

-- sort data (ORDER BY)
SELECT * FROM employee ORDER BY salary DESC;

-- sort data for Accounts department based on Salary
SELECT * from employee WHERE dept='Accounts' ORDER BY salary DESC;

-- limit the number of rows returned (LIMIT)
SELECT * FROM employee ORDER BY salary DESC LIMIT 5;

-- unique / distinct values (DISTINCT)
SELECT DISTINCT name FROM employee;
