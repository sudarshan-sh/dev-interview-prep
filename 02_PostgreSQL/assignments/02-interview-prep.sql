-- =========================================
-- PRACTICE: Full Repo Review (Databases, Tables, Constraints, Queries)
-- =========================================
 -- Schema (from 02-tables.sql / 03-constraints.sql):
--
-- Employee
--   - empid      int primary key
--   - name       varchar
--   - age        int
--   - salary     float
--   - city       varchar
--   - dept_type  varchar
--
-- Project
--   - projectid    int primary key
--   - project_name varchar
--   - start_date   date
--   - incharge     int  -> FOREIGN KEY references employee(empid)
--                          ON DELETE SET NULL ON UPDATE CASCADE
--
-- Users
--   - UserID  int
--   - name    varchar
--   - email   varchar
--   - PRIMARY KEY (UserID, email)
--
-- students
--   - StudentID    int primary key
--   - StudentName  varchar
--   - age          int  CHECK (age BETWEEN 3 AND 18)
--
-- Products
--   - ProductID     int primary key
--   - ProductName   varchar
--   - StockLevel    int DEFAULT 0
--   - ProductStatus varchar DEFAULT 'Pending'
--   - DateAdded     timestamp DEFAULT CURRENT_TIMESTAMP
 -- ===== A. DATABASES =====
-- 1. Write a command to create a database named 'interview_prep'.

CREATE DATABASE interview_prep;

-- 2. Write a command to drop the database 'interview_prep' only if it exists.

DROP DATABASE IF EXISTS interview_prep;

-- 3. Write a query to list all databases that are NOT template databases.

SELECT datname
from pg_database;

-- ===== B. TABLES & ALTER =====
-- 4. Create a table 'Department' with columns dept_id (int) and dept_name (varchar),
--    and make (dept_id, dept_name) a composite primary key.

CREATE TABLE Department (dept_id int PRIMARY KEY,
                                     dept_name varchar(100),
                                               ADD CONSTRAINT dept_id_name PRIMARY KEY (dept_id,
                                                                                        dept_name));

-- 5. Add a new column 'dept_id' (int) to the Employee table.

ALTER TABLE employee ADD dept_id INT;

-- 6. Write a command to rename the 'dept_id' column in Employee to 'department_id'.

ALTER TABLE employee RENAME COLUMN dept_id TO department_id;

-- 7. Write a command to drop the 'department_id' column from Employee.

ALTER TABLE employee
DROP COLUMN department_id;

-- 8. What is the difference between DROP TABLE and TRUNCATE TABLE? (answer in a comment)
DROP TABLE deletes the entire table structure along with its data, while TRUNCATE TABLE deletes only the data inside the table, leaving the structure intact for future use.
 -- ===== C. CONSTRAINTS =====
-- 9. Add a UNIQUE constraint on the 'email' column of the Users table.

ALTER TABLE Users ADD CONSTRAINT unique_email UNIQUE (email);

-- 10. Add a CHECK constraint on Products so that StockLevel can never be negative.

ALTER TABLE Products ADD CONSTRAINT positive_stocklevel CHECK (StockLevel >= 0);

-- 11. Add a FOREIGN KEY from a new 'Department' table's manager_id column to
--     Employee(empid), such that deleting the employee sets manager_id to NULL.

ALTER TABLE Department ADD CONSTRAINT fk_department_employee
FOREIGN KEY (manager_id) REFERENCES Employee (empid) ON DELETE SET NULL;

-- 12. Add a DEFAULT constraint so any new Employee row defaults 'city' to 'Unknown'.

ALTER TABLE Employee ADD CONSTRAINT default_city DEFAULT 'Unknown'
FOR city;

-- OR

ALTER TABLE Employee
ALTER COLUMN city
SET DEFAULT 'Unknown';

-- 13. Write a command to drop the CHECK constraint you added in Q10.
 -- ===== D. QUERIES (FILTERING / SORTING / DISTINCT) =====
-- 14. Select all employees whose name starts with 'A' (case-insensitive).

SELECT *
from employees
WHERE name ILIKE 'a%' -- 15. Select all employees with a salary NOT between 20000 and 50000.

    SELECT *
    from employees WHERE salary NOT BETWEEN 20000 AND 50000;

-- 16. Select all employees whose city is either 'Delhi', 'Mumbai', or NULL.

SELECT *
from employees
WHERE city IN ('Delhi',
               'Mumbai')
    OR city IS NULL;

-- 17. List all distinct cities present in the Employee table.

SELECT DISTINCT city
from employee;

-- 18. Select the top 3 highest paid employees, sorted by salary descending;
--     break ties by name ascending.

SELECT *
from employees
ORDER BY salary DESC,
         name ASC
LIMIT 3;

-- ===== E. CONCEPTUAL (for interview rounds) =====
-- 19. What happens if you try to DELETE an employee referenced by Project.incharge,
--     but the FOREIGN KEY has ON DELETE NO ACTION instead of SET NULL? (answer in a comment)
Since the project relies on the employee table so DB would restrict the deletion to maintain referential integrity resulting in a foreing key violation error.

-- ==================================
-- 20. Can a table have more than one UNIQUE constraint but only one PRIMARY KEY? Why? (answer in a comment)
Yes, a table can have multiple UNIQUE constraints but only one PRIMARY KEY. Since PRIMARY KEY must be a unique value and not accept NULL values.
While UNIQUE constraints cane be applied on the various values that can also accept the NULL values as well.