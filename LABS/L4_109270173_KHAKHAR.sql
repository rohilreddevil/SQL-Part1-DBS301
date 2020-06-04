-- ***********************
-- Name: Rohil Khakhar
-- ID: 109270173
-- Date: September 27th 2018
-- Date of Submission-  
-- Purpose: Lab 4 DBS301
-- ***********************

--Lab4 Begins Now--

--Q1: Displaying Values using mathematical oprations
-- Solution :
    
    SELECT to_char(ROUND((AVG(salary)- MIN(salary)),2), '$9999.99' ) AS "Real Amount"
    FROM EMPLOYEES;
    
--End Of File

--Q2: Displaying Department-Wise Data
--Solution:
    
    SELECT department_id, to_char(MAX(salary),'$99,999.99') AS "High" ,to_char(MIN(salary),'$99,999.99') AS "Low",
    to_char (AVG(salary),'$99,999.99') as "Avg" 
    FROM employees 
    GROUP BY department_id 
    ORDER BY AVG (salary) DESC;

--End Of File

--Q3: Using the Count Function
--Solution:
    
    SELECT department_id AS "Dept#", job_id AS "Job", COUNT(department_id) AS "How Many"
    FROM employees
    GROUP BY department_id, job_id
    HAVING COUNT(job_id) > 1 --only include jobs that involve more than one person
    ORDER BY "How Many" DESC;
    
--End Of File

--Q4: Specifications
--Solution:

    SELECT job_id as "Job Title", SUM(salary) as "Total Amount"
    FROM employees
    WHERE job_id NOT IN('AD_PRES', 'AD_VP')
    GROUP BY job_id
    HAVING SUM(salary) >12000
    ORDER BY SUM(salary) DESC;
    
--End Of File

--Q5: Displaying Manager Supervision Details
--Solution:

    SELECT manager_id , COUNT(manager_id) --counting the managers
    FROM employees
    WHERE manager_id NOT IN (100, 102, 102)
    GROUP BY manager_id
    HAVING COUNT(manager_id) >2 --if a manager supervises more than two employees
    ORDER BY COUNT(manager_id) DESC;

--End Of File

--Q6: Specifications using dates
--Solution:

    SELECT department_id, MAX(hire_date) AS "Latest",  MIN(hire_date) as "Earliest" 
    FROM employees
    WHERE department_id NOT IN(10, 20)
    GROUP BY department_id
    HAVING to_char (MAX(hire_date), 'cc') != to_char(sysdate, 'cc')
    ORDER BY "Latest" DESC; 
    
--End Of File







