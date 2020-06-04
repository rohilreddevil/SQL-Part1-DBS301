--WEEK3 LECTURE- 17th September 2018

SELECT * from Countries;

--Not using *

SELECT country_id AS "Country Code", 
        country_name AS "Country", 
        region_id AS "REGION"
    FROM countries;

-- WHERE clause    
SELECT country_id AS "Country Code", 
        country_name AS "Country", 
        region_id AS "REGION"
    FROM countries
    WHERE region_id=2;
    
--'WHERE' with STRINGS
SELECT country_id AS "Country Code", 
        country_name AS "Country", 
        region_id AS "REGION"
    FROM countries
    WHERE country_name= 'Canada';
    
-- The = can be replaced with LIKE for strings
--ALIAS IS NOT A STRING... its the assignment of a new name
-- Double Quote- for definitions
--Single Quotes- for strings

--WILIDCARDS
SELECT country_id AS "Country Code", 
        country_name AS "Country", 
        region_id AS "REGION"
    FROM countries
    WHERE country_name LIKE 'C%';
-- begins with C : C%
--ends with C : %C
-- C is in the middle- %C%

----------------------------------------------------------------------

--how do we know that the data is correct? what is our assumption??
--we are assuming that the data was entered in capital letters

--SQL is non case sensitive

UPDATE countries
    SET country_name= 'canada'
    WHERE country_name= 'CANADA';

-- we still need both Canada and China
SELECT country_id AS "Country Code", 
        country_name AS "Country", 
        region_id AS "REGION"
    FROM countries
    WHERE country_name LIKE 'C%'
    OR country_name LIKE 'c%';
    
-- LETS NOT USE 'OR'
    
SELECT country_id AS "Country Code", 
        country_name AS "Country", 
        region_id AS "REGION"
    FROM countries
    WHERE UPPER (country_name) LIKE 'C%'; --convert the country name to capital
    
-- Search for an item where there could be more than one criteria (i.e. Ontario or Quebec)

SELECT country_id,
        country_name,
        region_id
    FROM countries
    WHERE region_id IN (2,3); --2 or 3 (A set statement)
    
--more functions (BETWEEN)
--list between 30 and 80
SELECT *
    FROM employees
    WHERE department_id BETWEEN 50 and 80;

    --this was inclusive (50 and 80)

--all other departments
SELECT *
    FROM employees
    WHERE department_id <50 OR department_id >80;
    --THERE IS A BETTER WAY

SELECT *
    FROM employees
    WHERE department_id NOT BETWEEN 50 AND 80; --50 and 80 NOT included
    
--list all employees whose last name starts with 'k' or first name ends with 'a'
SELECT *
    FROM employees
    WHERE UPPER (last_name) LIKE 'K%'
    OR 
    LOWER(first_name) LIKE '%a';
    
--ALSO only list those hired before 1988 or after 1997
SELECT *
    FROM employees
    WHERE (UPPER (last_name) LIKE 'K%'
    OR 
    LOWER(first_name) LIKE '%a'
    AND 
    hire_date < to_date ('01011998', 'ddmmyyyy') 
    OR
    hire_date >= to_date('01011998', 'ddmmyyyy')); --universal date format

--ORDER OF PRECEDENCE
--statements have an order in which they run
--1. FROM
--2. WHERE
--3. SELECT 
--4. ORDER BY

--ALIASES cannot be used in 'WHERE'
--but they can be used in 'ORDER-BY'
SELECT employee_id IDnum,
first_name || ' ' || last_name AS "Full Name"
FROM employees
WHERE first_name || ' ' || last_name LIKE "E%"
ORDER BY "IDnum";


--second 'sort' will only happen if the first one is IDENTICAL

--USING COLUMN INDEXES
SELECT employee_id, last_name, first_name AS "fname", job_id
FROM employees
ORDER BY 2,3 DESC; --ORDER BY second field, followed by third field.


--PARAMETERS- asking for dynamic informtion
SELECT * 
    FROM countries
    WHERE region_id= &InputNum; 
    -- This sign & creates a variable, allowing the user to ask for input
    --dynamically changes results

--CREATE A TOOL TO FIND PEOPLE (have to do more than once)

SELECT first_name, last_name
    FROM employees
    WHERE UPPER(first_name) LIKE UPPER('&Initial%'); --combining parameter and wildcard
                                                     --where the first name is like the initial
                                                     -- prompts the user for an input

--THE CONCEPT OF DUAL
SELECT sysdate FROM dual; --this table does not exist in the database, BUT IT WILL RUN
--it will display today's date

--date of the next saturday
SELECT sysdate -10 AS "10 days ago"
    FROM dual; --find out the date 10 days ago


SELECT NEXT_DAY(sysdate, 'Saturday') AS "Next Saturday"
    FROM DUAL;

--3 sundays from now
SELECT NEXT_DAY(sysdate, 'Sunday')+14 AS "Next Sunday"
    FROM DUAL;































































