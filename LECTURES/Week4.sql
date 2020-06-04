--WEEK4 
--MultiRow Functions, Aggregate Functions and Grouping
--24/09/18

--Generic form
-----------------------------------------------------------------------------------------------------------------
    --SELECT < columns and aliases comma separated
    --FROM <tablename>
    --WHERE <condition>
    --GROUP BY <group by expressions> -- new addition.. allows you to aggregate values together
    --HAVING <grouping conditions> --new addition.. the conditions can be applied to something that can be grouped
    --ORDER BY <order by statement> .. comma separated

-------------------------------------------------------------------------------------------------------------------

--ORDER OF PRECEDENCE
--statements have an order in which they run
--1. FROM
--2. WHERE
--3. HAVING (new)
--4. SELECT 
--5. ORDER BY

--WHERE WILL THE 'GROUP BY' CLAUSE BE FITTED

--Total number of employees that work for the company

SELECT * FROM employees;
--Not the ideal way since this is just a list
--SELECT COUNT(*) AS "Num Employees" -- the (*) gets everything but we DON'T need all the fields

SELECT COUNT(employee_id) AS "Num Employees" -- hence we only need the PRIMARY KEY to count. Accurate and efficient
FROM employees;
--Scalar Query

--displays the number 20

--QUERY TYPES:
    -- Table Queries (returns tabular data)
    -- Scalar Queries (going to return a number)
    
-- Lets get the number of employees working in each department

SELECT department_id, COUNT(employee_id) AS "Number of Employees"
FROM employees
GROUP BY department_id
ORDER BY department_id;

--********************************************************
--do not include primary key when doing aggregate functions
--*********************************************************

--Lets show the manager id from each department

SELECT department_id, manager_id, COUNT(employee_id) AS "Number of Employees"
FROM employees
GROUP BY department_id
ORDER BY department_id;
                --ERROR

--***************************************************************************************************************************
--SQL GROUP BY RULE-- Any fields in the SELECT portion NOT part of an aggregate function MUST MUST MUST be included in GROUP BY 
--***************************************************************************************************************************

--HENCE
--*************************************************************************************
--when you group by multiple columns, you are grouping my a combination of those columns
--*************************************************************************************
SELECT department_id, manager_id, COUNT(employee_id) AS "Number of Employees"
FROM employees
GROUP BY department_id, manager_id
ORDER BY department_id;
                
--But this does not answer the original question
                
--USING 'DISTINCT'
--lets display the number of different departments that have employees in the database

SELECT COUNT(department_id) AS "Num Depts"
FROM employees;
-- outputs the number 19
-- WHAT ?? there are only 8 departments originally but this gives 19
    --duplicates are counted twice
    
SELECT COUNT (DISTINCT department_id) AS "Num Depts"--only distinct departments
FROM employees;
--displays 7 departments... 7 departments have employees


--USING 'NVL'
    --NVL- checks for null values and automatically replace it with some default values

-- Find the average commission rate for employees

SELECT AVG(commission_pct) as "Average" -- the AVG() aggregate function
FROM employees;


SELECT AVG(NVL(commission_pct, 0)) as "Average Commission"  --replaces any possible null values found in commission_pct
FROM employees;                                                 --with 0


--OTHER FUNCTIONS
--some of the aggregate functions
    --COUNT
    --AVG
    --SUM
    --MAX
    --MIN
    --VAR (var)
    --ST_DEV (standard deviation)
    
    
--Produce a single SQL statement that returns a SINGLE line result that displays the
--minimum, maximum and average salaries for all employees

SELECT MIN(salary) AS "Smallest", MAX(salary) AS "Biggest", AVG(salary) as "Average"
FROM employees;
--It does not look like currency
SELECT to_char ( MIN(salary), '$999,999.99' )AS "Smallest", 
       to_char ( MAX(salary), '$999,999.99') AS "Biggest",
       to_char ( AVG(salary), '$999,999.99') as "Average"
FROM employees;

--HAVING
--Display the average salary from employees in each job in each department
--But only those where the average is over $10,000.00

SELECT department_id, job_id, AVG(salary) AS "Avg Salary"
FROM employees
GROUP BY department_id, job_id
HAVING AVG(salary) > 10000
ORDER BY department_id, job_id;

--lets test alias placement

SELECT department_id, job_id, AVG(salary) AS "Avg Salary"
FROM employees
GROUP BY department_id, job_id
HAVING AVG(salary) > 10000
ORDER BY department_id, job_id;
            --ERROR.. SELECT HAPPENS AFTER 'HAVING'

--********************************************************************************************
--1. FROM
--2. WHERE
--3. GROUP BY
--4. HAVING
--5. SELECT                ORDER OF PRECEDENCE
--6. ORDER BY
--*********************************************************************************************


--Using Both HAVING and WHERE
--Repeat the Previous example but only include departments 20, 60, 80, 90

SELECT department_id, job_id, AVG(salary) AS "Avg Salary"
FROM employees
WHERE department_id IN(20, 60, 80, 90)
GROUP BY department_id, job_id
HAVING AVG(salary) > 10000
ORDER BY department_id, job_id;