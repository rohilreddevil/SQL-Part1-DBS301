-- ***********************
-- Name: Rohil Khakhar
-- ID: 109270173
-- Date: 15th October 2018
-- Date of Submission- 15th October 2018
-- Purpose: Lab 6 DBS301
-- ***********************

--Lab6 Begins Now

--Q1: AUTOCOMMIT
--Solution: 
    
    SET AUTOCOMMIT ON;
    
--End Of File--

--Q2: INSERT STATEMENT
--Solution:

INSERT INTO employees
(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (22, 'Rohil', 'Khakhar', 'RKHAKHAR', '515.129.6274', sysdate, 'IT_PROG', NULL, 0.2, 100, 90 );

--End Of File--

--Q3: UPDATE STATEMENT:
--Solution:

UPDATE employees
SET salary = 2500
WHERE last_name IN ( 'Matos','Whalen');
--WHERE last_name = 'Matos' 
--AND last_name = 'Whalen';

--End Of File--

--Q4: Displaying Last Names of All Employees in same department as Abel
--Solution:

SELECT last_name
FROM employees
WHERE department_id IN(SELECT department_id
                        FROM employees
                        WHERE last_name = 'Abel');
--End Of File--

--Q5: Display the last name of the lowest paid Employees
--Solution:

SELECT last_name
FROM employees
WHERE salary IN (SELECT MIN (salary)  
                 FROM employees);

--End Of File--

--Q6: Display the city that the lowest paid employees are located in
--Solution:

SELECT  DISTINCT city
FROM ( employees e JOIN departments d
    ON (e.department_id = d.department_id)) JOIN locations l
    ON (d.location_id = l.location_id)
WHERE e.salary= (SELECT MIN(salary) 
                    FROM employees);

--End Of File--

--Q7: Display last_name, departmentid and salary of the lowest paid employees in each department
--Sort by Department ID
--Solution:

    SELECT DISTINCT last_name, department_id, salary
    FROM employees 
    WHERE salary IN (SELECT MIN(salary)
                        FROM employees
                        GROUP BY department_id)
    ORDER BY department_id;

--End Of File

--Q8: Displaying the last name of the lowest paid employee(s) in each city
--Solution: 

    SELECT last_name
    FROM (employees  JOIN departments
        USING (department_id))
            JOIN locations 
                USING (location_id)
    WHERE salary IN (SELECT MIN(salary)
                        FROM (employees  JOIN departments
                        USING (department_id))
                        JOIN locations 
                            USING (location_id)
                            GROUP BY city);
                                   
--End Of File--

--Q9: last name and salary for all employees who earn less than the lowest salary in any department
--sort by top salaries and then by last name
--Solution:

    SELECT last_name, salary
    FROM employees
    WHERE salary IN (SELECT MIN (salary)
                        FROM employees
                        GROUP BY DEPARTMENT_ID)
    ORDER BY salary DESC, last_name;
    
--End of File--

--Q10: Display Last name, job title and salary for all employees whose salary matches
--Any of the salaries from the IT department
--DO NOT USE JOIN
--Solution:

    SELECT last_name, job_id, salary 
    FROM employees
    WHERE salary IN (SELECT salary 
                    FROM employees
                    WHERE department_id = 60)
    AND department_id != 60
    ORDER BY salary ASC, last_name;
    
--End Of File--

--End of Lab6--

















