-- ***********************
-- Name: Rohil Khakhar
-- ID: 109270173
-- Date: September 20th 2018
-- Date of Submission- 20th September 2018 
-- Purpose: Lab 3 DBS301
-- ***********************

--LAB3 BEGINS NOW

--Q1: Displaying Date using to_char function and sysdate
--Solution:

    SELECT to_char(sysdate+1, 'Month dd"st of year" yyyy') AS "Tomorrow"
    FROM dual; --+1 indicates tomorrow (the next day)

--END OF FILE--

--Q2: Salary Increamnets
--Solution: 
    
        SELECT last_name, first_name, salary, (salary +(salary*0.05)) AS "Good Salary",((salary/100)*5*12) AS 
        "Annual Pay Increase"
        FROM employees
        WHERE department_id in(20, 50, 60);
        
--END OF FILE--

--Q3: Concatenation:
--Solution:

        SELECT last_name || ', ' || first_name || ' is ' || job_id
        FROM employees
        WHERE (upper (first_name) LIKE 'C%' OR upper(first_name) LIKE 'K%')
        AND upper(last_name) LIKE '%S'
        ORDER BY last_name;
        
--END OF FILE--

--Q4:Working with the duration of employees in a firm
--Solution:

        SELECT last_name, hire_date, ROUND((sysdate - hire_date)/365) AS "Years Worked"
        FROM employees
        WHERE hire_date <= to_date('01011992', 'DDMMYYYY')
        ORDER BY "Years Worked";

--End Of File--

--Q5: Displaying Cities and Province
--Solution:

    SELECT city, country_id, NVL(state_province, 'Unknown Province') AS "State and Province"
    FROM locations
    WHERE upper(city) LIKE 'S%'
    AND length(city) >=8;
    
--End of File--

--Q6: Specifications
--Solution:

    SELECT last_name, hire_date, salary, to_char(NEXT_DAY(ADD_MONTHS(hire_date, 12),'THURSDAY'),'Day,Month 
    "the" Ddspth "of year" yyyy')
    AS "Review Day"
    FROM employees
    WHERE hire_date > to_date('01011997', 'ddmmyyyy')
    ORDER BY "Review Day";
    
--End of File--
    






