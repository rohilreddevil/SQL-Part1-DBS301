-- ***********************
-- Name: Rohil Khakhar
-- ID: 109270173
-- Date: 4th November 2018
-- Date of Submission- 4th November 2018
-- Purpose: Lab 7 DBS301
-- ***********************

--Lab7 Begins Now

--Q1- Department List Specifications
--Solution--

SELECT department_id
FROM departments

MINUS
--All the rows from the first table that are not present in the second table
--All department_id's that are there in the 1st table but NOT in the 2nd table

SELECT department_id
FROM employees
WHERE department_id =50
ORDER BY department_id;

--End Of File

--Q2-Country Specifications
--Solution:

SELECT DISTINCT country_id, country_name
FROM countries
MINUS
(SELECT DISTINCT country_id, country_name
FROM countries JOIN locations
    using(country_id) 
        JOIN departments 
            USING (location_id));

--End Of File

--Q3- Meeting the needs of the vice president
--Solution:
--We need to use UNION ALL instead of UNION 
--If we used UNION, then it would automatically set the order for us (10, 20, 50...)
--UNION ALL has that flexibility of not having the order set by default.
--OUTPUT IS SORTED IN ASCENDING ORDER BY DEFAULT in UNION.. NOT UNION ALL

SELECT DISTINCT job_id, department_id
FROM employees
WHERE department_id = 10
UNION ALL
SELECT DISTINCT job_id, department_id
FROM employees
WHERE department_id = 50
UNION ALL
SELECT DISTINCT job_id, department_id
FROM employees
WHERE department_id = 20;

--End Of File

--Q4- Job Consistency
--Solution:

SELECT employee_id, job_id
FROM employees

INTERSECT

SELECT employee_id, job_id
FROM job_history;

--End Of File

--Q5- Single Report Creation
--Solution:

SELECT last_name, department_id, TO_CHAR(null) AS "Department_Name"
FROM employees
UNION 
SELECT TO_CHAR(null) AS "Last_Name", department_id, department_name
FROM departments;

--End Of File

--End Of Lab7