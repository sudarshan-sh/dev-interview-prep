-- =========================================
-- PRACTICE: ALTER TYPE (adding a new ENUM value)
-- =========================================

-- Context:
-- employee.dept is populated from the ENUM type 'department_type',
-- which currently has these values: 'HR', 'Sales', 'Accounts', 'Technology'.

-- Queries:
-- 1. Add a new value 'Backoffice' to the 'department_type' ENUM type
--    (without dropping/recreating the type).
ALTER TYPE department_type
ADD VALUE 'Backoffice';
-- 2. Insert a new employee named 'Ganesh' (age 36, salary 42000) into the
--    employee table with dept set to 'Backoffice'.
INSERT INTO employee (empid, name, age, salary, dept)
VALUES (8, 'Ganesh', 36, 42000, 'Backoffice')
RETURNING empid, name, age, salary;