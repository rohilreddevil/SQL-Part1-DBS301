-- ***********************
-- Name: Rohil Khakhar
-- ID: 109270173
-- Date: October 4th 2018
-- Date of Submission- 09/10/2018
-- Purpose: Lab 5 DBS301
-- ***********************

--Lab5 Begins now

--PART A

--Q1: Simple Joins
-- Solution:
       
 SELECT d.department_name, l.city, l.street_address,l.postal_code
    FROM departments d, locations l 
    ORDER BY l.city, d.department_name;

-- End Of File--

--Q2: Field Specifications and Three way Joins
--Solution:

SELECT  last_name || ' ' || first_name AS "Employee Name", hire_date, salary, department_name, city 
FROM employees e JOIN departments d
  --FROM employees, departments, locations
   ON e.department_id = d.department_id
    JOIN locations l 
       ON d.location_id = l.location_id
WHERE UPPER (d.department_name) LIKE 'A%'
OR 
UPPER (d.department_name) LIKE 'S%' 
ORDER BY department_name, "Employee Name";

--End Of File--

--Q3: Dealing with Managers
--Solution:

SELECT first_name || ' ' || last_name as "Manager Name", department_name, city, postal_code, state_province
 FROM (employees e JOIN departments d
        ON e.manager_id = d.manager_id)
            JOIN locations l
                ON d.location_id = l.location_id
WHERE LOWER (l.state_province) in ( 'ontario', 'california', 'washington')
ORDER BY l.city, d.department_name;    

--trial attempt (for experimenting)

/*SELECT first_name || ' ' || last_name as "Manager Name", department_name, city, postal_code, state_province
    FROM employees, departments, locations
WHERE LOWER (state_province) in ( 'ontario', 'california', 'washington')
ORDER BY city, department_name; */   

--End Of File--

--Q4: Further Column Labelling - Self Join
--Solution:

SELECT e.last_name AS "Employee", e.employee_id AS "Emp#", m.last_name AS "Manager", e.manager_id AS "Mgr#"
    FROM employees e JOIN employees m -- employee id of the MANAGER is the same as manager id of the employee
       ON e.manager_id = m.employee_id;
       
--End Of File--

--END OF PART A--

--PART B BEGINS NOW--

--Q5: Non Simple Joins with the USING Keyword
--Solution:

SELECT department_name, city, street_address, postal_code, country_id
FROM departments d LEFT OUTER JOIN locations l
    USING (location_id)
ORDER BY department_name DESC;

--End Of File--

--Q6: Further Complex Joins
--Solutions:

SELECT  first_name || ' ' || last_name AS "Employee Name", hire_date, salary, department_name
FROM employees e JOIN departments d
   ON e.department_id = d.department_id
WHERE UPPER (d.department_name) LIKE 'A%'
OR 
UPPER (d.department_name) LIKE 'S%' 
ORDER BY d.department_name, e.last_name;

--End Of File--

--Q7: Dealing With Managers (AGAIN)
--Solution:

SELECT last_name || ' ' || first_name as "Manager Name", department_name, city, postal_code, state_province
 FROM (employees e JOIN departments d
        ON e.manager_id = d.manager_id)
            JOIN locations l
                ON d.location_id = l.location_id
WHERE LOWER (l.state_province) in ( 'ontario', 'california', 'washington')
ORDER BY l.city, d.department_name;    

--End Of File--

--Q8: Dealing with salaries
--Solution:

SELECT department_name, to_char(MAX(salary),'$99,999.99') AS "High" ,to_char(MIN(salary),'$99,999.99') AS "Low", to_char (AVG(salary),'$99,999.99') as "Avg" 
FROM employees e FULL OUTER JOIN departments d
    ON (e.department_id = d.department_id)
GROUP BY d.department_name
ORDER BY "High"; 

--End of File--

--Q9: Managers and Employees
--Solution:

SELECT e.last_name AS "Employee", e.employee_id AS "Emp#", m.last_name AS "Manager", e.manager_id AS "Mgr#"
    FROM employees e LEFT OUTER JOIN employees m 
       ON e.manager_id = m.employee_id
    WHERE e.manager_id IS NULL
  

--End Of File--

















































