-- ***********************
-- Name: Rohil Khakhar
-- ID: 109270173
-- Date: September 13th 2018
-- Date of Submission- September 17th 2018
-- Purpose: Lab 2 DBS301
-- ***********************

--LAB2 STARTS NOW--

--Q1: Listing Field Names with a certain set of conditions and making use of sorting and the to_char default function
--Solution:
    
    SELECT employee_id, last_name, to_char(salary , '$999,999.99') AS Salary -- using alias for salary to make it readable
    FROM employees
    WHERE salary >=9000 AND salary <=11000
    ORDER BY salary DESC, last_name ASC; -- order by highest salary
    
 --END OF FILE--
 
 --NOTE-only use the to_date() function when hard coding a date(hardcoding it in the month- date, year format, etc). The server
   --needs to know about this format

--Q2: Modification of the previous query based on the condition
--Solution:
    
    SELECT employee_id, last_name, to_char(salary , '$999,999.99') AS Salary -- to_char() is a default function
    FROM employees
    WHERE (job_id IN( 'IT_PROG' ,'SA_REP')) AND (salary >=9000 AND salary <=11000) -- adding another 'or' condition
    ORDER BY salary DESC, last_name ASC; 
    
--END OF FILE--
 
--Q3: Further modifications made based on different salary expectations. Same job titles but outside the earlier salary range
--Solution:

    SELECT employee_id, last_name, to_char(salary , '$999,999.99') AS Salary 
    FROM employees
    WHERE (job_id IN( 'IT_PROG' ,'SA_REP')) AND (salary <9000 OR salary >11000) --outside the salary range mentioned earlier
    ORDER BY salary DESC, last_name ASC; 
 
--END OF FILE

--Q4: Fetching long term employee lists
--Solution:

   SELECT last_name, job_id, to_char(salary , '$999,999.99') AS Salary , hire_date-- added to check if the conditon works 
   FROM employees
   WHERE hire_date < to_date('1998/01/01', 'YYYY/MM/DD')--arguments that we are passing and the format that is expected
   ORDER BY hire_date DESC;
 
--END OF FILE
 
 --user defined reports for q 7,8,9
 
 --Q5: Modifying the earlier command and displaying those with a salary greater than 10000
--Solution:

   SELECT last_name, job_id, to_char(salary , '$999,999.99') AS Salary , hire_date-- added to check if the conditon works 
   FROM employees
   WHERE hire_date < to_date('1998/01/01', 'YYYY/MM/DD') AND salary >10000
   ORDER BY hire_date DESC;

--END OF FILE

 --Q6: Wildcard implementation
--Solution:

   SELECT job_id AS "Job Title", first_name||' '||last_name AS "Full name"
   FROM employees
   WHERE LOWER(first_name) LIKE ('%e%'); -- lower is a default function

--END OF FILE


--O7: Report Creation
-- Solution:
    
    SELECT last_name, salary, commission_pct
    FROM employees
    WHERE commission_pct>0;
    
--END OF FILE

--O8: Report Creation- Descending Salaries
-- Solution:
    
    SELECT last_name, salary, commission_pct
    FROM employees
    WHERE commission_pct>0
    ORDER BY salary DESC;
    
--END OF FILE
 
 --O9: Report Creation- Numeric sorting
-- Solution:
    
    SELECT last_name, salary, commission_pct
    FROM employees
    WHERE commission_pct>0
    ORDER BY 2 DESC;
    
--END OF FILE

--END OF LAB2--
