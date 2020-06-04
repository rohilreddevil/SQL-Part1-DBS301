--Lecture- 10th September 2018
--SELECT syntax

SELECT * 
    FROM employees
    WHERE salary >= 6000;
--asterisk- selects all fields, and all rows

SELECT employee_id, first_name, last_name, hire_date, job_id, salary
FROM employees
WHERE salary >= 6000;

--aliases - alternate names for fields
SELECT employee_id as "Employee ID", first_name as "First Name", last_name, hire_date, job_id, salary
FROM employees
WHERE salary >= 6000;
--alias cannot have space if it is not in quotes
-- if you do not quote aliases, it will display it in ALL CAPS
-- if you use quotes, you can then be case sensitive
-- if you use quotes, you do not necessarily need the keyword "As"
--"As" is recommended for readability
--DRAWBACK OF ALIAS
--      as the data is sent to an application, that column is known as "First Space Name"

--WILDCARDS

SELECT * FROM employees;

SELECT employee_id, first_name, last_name, job_id
FROM employees
WHERE last_name LIKE 'D%' ; /*Where the names start with D*/
--'%D' - ends with D
--CASE SENSITIVE

--STRING CONCATENATION
--use a function called concat OR
SELECT first_name || ' ' || last_name
FROM employees;
--SINGLE QUOTAIONS NEEDED
--Double Quotes are used for DEFINING THINGS
--Double Quotes used in defining aliases