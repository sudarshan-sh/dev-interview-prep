-- =========================================
-- TABLES: CREATE, ALTER, DROP
-- =========================================

-- 1. CREATE TABLE
CREATE TABLE Employee (
    empid  int PRIMARY KEY,
    name   varchar(255) NOT NULL,
    age    int,
    salary float(10),
    CONSTRAINT C1 UNIQUE (empid)
);

SELECT * FROM Employee;

DELETE FROM Employee WHERE name = 'Diwakar';

-- 2. DROP TABLE
DROP TABLE employee;

-- 3. INSERT DATA
INSERT INTO employee (empid, name, age, salary)
VALUES (5, 'Ritesh', 25, 75000);

-- 4. MODIFY TABLE COLUMN using ALTER
ALTER TABLE employee ALTER COLUMN name SET NOT NULL;
ALTER TABLE employee ALTER COLUMN age SET NOT NULL;
ALTER TABLE employee ALTER COLUMN age DROP NOT NULL;

-- adding a NOT NULL constraint to an existing column that already has NULL values (e.g. age):
UPDATE employee SET age = 34 WHERE age IS NULL AND empid = 6;

-- now age can safely be set back to NOT NULL
ALTER TABLE employee ALTER COLUMN age SET NOT NULL;

-- 5. table with a FOREIGN KEY relationship
-- (see 03-constraints.sql for the standalone UNIQUE / FOREIGN KEY / CHECK constraint examples)
CREATE TABLE Project (
    projectid    int PRIMARY KEY,
    project_name varchar(255) NOT NULL,
    start_date   DATE,
    incharge     int,
    FOREIGN KEY (incharge) REFERENCES employee(empid)
);

INSERT INTO Project (projectid, project_name, start_date, incharge)
VALUES
    (1, 'Brainstation Foundation', '2026-01-15', 3),
    (2, 'I4E Web App', '2026-02-01', 1),
    (3, 'NFD', '2026-03-01', 3),
    (4, 'IV Capital', '2026-03-01', 2),
    (5, 'InvestValue Titans', '2026-01-15', 2);

-- insert another set
INSERT INTO Project (projectid, project_name, start_date, incharge)
VALUES (6, 'InvestValue Research Basket', '2026-01-15', 4);

-- 6. ALTER TABLE: add / modify / rename / drop columns
-- add a column
ALTER TABLE employee ADD city varchar(100);
ALTER TABLE employee ADD department_type varchar(100);

CREATE TYPE department_type AS ENUM ('HR', 'Sales', 'Accounts', 'Technology');

ALTER TABLE employee
ALTER COLUMN department_type TYPE department_type USING department_type::department_type;

-- run inside db1=# to inspect the enum type:
-- \dT+ department_type

-- rename a column
ALTER TABLE employee RENAME COLUMN department_type TO dept_type;

-- drop a column
ALTER TABLE employee DROP COLUMN dept;

-- update rows with the department value
UPDATE employee SET dept = 'Sales' WHERE empid IN (2, 5);

-- instead of seeing 'UPDATE 1', the RETURNING clause allows to see the modified rows
UPDATE employee 
SET salary=56000 WHERE empid=4
RETURNING empid, name, salary;

UPDATE employee 
SET salary = CASE empid
    WHEN 7 THEN 40000 -- Manish
    WHEN 1 THEN 150000 -- Peeyush
    WHEN 3 THEN 155000 -- Tushar
    WHEN 6 THEN 50000  -- Manoj
    WHEN 2 THEN 55000  -- Manish
END
WHERE empid IN (7, 1, 3, 6, 2)
RETURNING empid, name, age, salary, city, dept;