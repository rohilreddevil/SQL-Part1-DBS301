-- ***********************
-- Name: Rohil Khakhar
-- ID: 109270173
-- Date: 8th November 2018
-- Date of Submission- 12th November 2018 
-- Purpose: Lab 8 DBS301
-- ***********************

--Lab8 Begins Now

--Q1:Display the names of the employees 
--whose salary is the same as the lowest salaried employee in any department.
--Solution:

SELECT first_name, last_name
FROM employees
WHERE salary IN (SELECT MIN(salary) 
                 FROM employees
                 GROUP BY department_id);
--SELECT salary FROM employees WHERE first_name = 'Randall';

--End Of File

--Q2: Display the names of the employee(s) 
--whose salary is the lowest in each department.
--Solution:

SELECT e.first_name, e.last_name, e.department_id, d.Minimum
    FROM employees e JOIN (SELECT department_id, MIN(salary) Minimum 
                           FROM employees 
                           GROUP BY department_id) d 
                            ON(e.department_id= d.department_id) AND e.salary= d.Minimum 
ORDER BY last_name;

--End Of File

--Q3: Give each of the employees in question 2 a $100 bonus.
--Solution:

UPDATE employees
SET SALARY = SALARY +100
WHERE last_name IN (SELECT last_name 
                    FROM employees
                    WHERE (department_id, salary) IN (SELECT department_id, MIN(salary)
                                                      FROM employees 
                                                      GROUP BY department_id));

--End Of File

--Q4: Create a view named ALLEMPS that consists of all employees 
--includes employee_id, last_name, salary, department_id, department_name, city and country (if applicable)
--Solution:

CREATE VIEW ALLEMPS AS
    SELECT e.employee_id, e. last_name, e.salary, e.department_id, d.department_name, l.city, l.country_id
    FROM employees e JOIN departments d
            ON(e.department_id= d.department_id)
                JOIN locations l 
                    USING(location_id);

--End Of File

--Q5: Playing around with the VIEW

--a) Display the employee_id, last_name, salary and city for all employees
--Solution:

SELECT employee_id, last_name, salary, city
FROM allemps;

--End Of File

--b) Display the total salary of all employees by city
--Solution:

SELECT city, SUM(salary) AS "Total Salary"
FROM allemps
GROUP BY city;

--End Of File

--c) Increase the Salary of the lowest paid employees in each department by 100
--Solution:

UPDATE allemps
SET SALARY = SALARY +100
WHERE last_name IN (SELECT last_name 
                    FROM employees
                    WHERE (department_id, salary) IN (SELECT department_id, MIN(salary)
                                                      FROM employees 
                                                      GROUP BY department_id));

--End Of File

--d) What Happens if you try to insert an employee by providing values for all Columns in this view??
--Solution: Not Allowing modification of more than one table using a join specifically

--Given its error prone state, I have commented this statement out to avoid any further complications

/*INSERT INTO allemps (employee_id, last_name, salary, department_id, department_name, city, country_id)
            VALUES (41, 'Messi', 15000.00, 70, 'IT_PROG', 'Toronto', 'CA' );*/

--Error Message Generated -- 
--Error starting at line : 98 in command -
/*INSERT INTO allemps (employee_id, last_name, salary, department_id, department_name, city, country_id)
            VALUES (41, 'Messi', 15000.00, 70, 'IT_PROG', 'Toronto', 'CA' )

Error at Command Line : 98 Column : 69
Error report -
SQL Error: ORA-01776: cannot modify more than one base table through a join view
01776. 00000 -  "cannot modify more than one base table through a join view"
*Cause:    Columns belonging to more than one underlying table were either
           inserted into or updated.
*Action:   Phrase the statement as two or more separate statements. */

--End Of File

--e) Attempting to delete a particular employee from a view
--Solution:

DELETE FROM allemps
WHERE last_name = 'Vargas';
--Yes it works. This is the subsequent message I am getting on the screen -> "1 row deleted"

--End Of File

--Q6: Creating Another View
--Solution:

CREATE VIEW ALLDEPTS AS 
    SELECT d.department_id, d.department_name, l.city, l.country_id
        FROM departments d JOIN locations l
            USING(location_id);

--End Of File

--Q7: Using the recently created view

--a) For all departments display the department_id, name and city

SELECT department_id, department_name, city
FROM alldepts;

--End Of File

--b) For each city that has departments located in it, display the NUMBER of departments by city
--Obviously, this involves the COUNT() function

SELECT COUNT(department_id) AS "Departments", city
FROM alldepts
GROUP BY city;

--End Of File

--Q8: Creating another view- this time with some specifications
--Solution:

CREATE VIEW ALLDEPTSUMM AS
    SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS "NUM_EMPLOYEES", 
    COUNT(a.employee_id) AS "Salaried Employees", SUM(e.salary) AS "Total Salary"
    FROM departments d LEFT OUTER JOIN employees e
        ON(d.department_id= e.department_id) 
            LEFT OUTER JOIN (departments d LEFT OUTER JOIN employees a 
                                ON(d.department_id= a.department_id) )
                            ON (a.employee_id= e.employee_id) --self join to get salaried employees differently.
 WHERE a.employee_id IN(SELECT employee_id 
                       FROM employees 
                       WHERE commission_pct IS NULL)--distinguishing salaried from the regular employees 
 GROUP BY d.department_id, d.department_name;
                   
                        
--End Of File

--Q9: Using this wonderful view
--Solution:

SELECT department_name, num_employees
FROM alldeptsumm
WHERE num_employees > (SELECT AVG(num_employees) AS "Average"
                               FROM alldeptsumm)
ORDER BY department_name;

--End Of File

--Q10: GRANT statements

--a) 
--Solution:

GRANT SELECT ON employees to dbs301_183g12;
GRANT SELECT, INSERT, UPDATE on departments to dbs301_183g12;

--"Grant Succeeded" Displayed on the screen
--That number is my dbs301 ID... LOL!!!!!

--End Of File

--b) One Final Chore- REVOKE!!!!
--Solution:

--REVOKE INSERT, UPDATE on departments FROM dbs301_183g12;
--Didnt work :(

--End Of File

--End Of Lab8
