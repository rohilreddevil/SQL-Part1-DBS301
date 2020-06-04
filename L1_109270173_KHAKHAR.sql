-- ***********************
-- Name: Rohil Khakhar
-- ID: 109270173
-- Date: September 6th 2018
-- Date of Submission- September 10th 2018
-- Purpose: Lab 1 DBS301
-- ***********************

--LAB1 STARTS NOW--

--Q1: Exploring SELECT commands and their size based on the data
--Solution: 
--  Following are the sql statements being used

    SELECT * FROM employees;
    SELECT * FROM  departments;
    SELECT * FROM job_history;

--written solutions:
--      1) Widest Table- employees
--      2) Longest Table- employees 

--END OF FILE--

--Q2: Rectifying SQL commands
--Solution:
--      The Command that needs recitification is :

        /*SELECT last_name “LName”, job_id “Job Title”, 
          Hire Date “Job Start”
          FROM employees; */
          -- this statement generates an error
        
      -- the way to rectify this to exclude the aliases for each field which are a representation of a temporary name for fields
      -- hence, the commented incorrect statement above can be rectified as follows:
       
       SELECT last_name , job_id,  
       hire_date 
       FROM employees;
     
     --hence proved that only the exact field names that the user wishes to retrieve are only required

--END OF FILE--

--Q3: Rectifying Coding Errors
--Solution:
--  The Statement that needs rectification is :
    
    /*SELECT employee_id, last name, commission_pct Emp Comm,
    FROM employees;*/

--Observations: incorrect field names present (last name) and the field alias "Emp Comm" does not exist.
--              finally, the comma after "Emp Comm" is inappropriate because there is no forthcoming field after it
--Rectification is as follows 
    SELECT employee_id, last_name, commission_pct
    FROM employees;
    
--END OF FILE--

--Q4: Identifying the command used to display the structure of the table LOCATIONS
--Solution: The command used to display the table structure is the "DESCRIBE" command.
--          The table name is placed immediately after the "DESCRIBE KEYWORD"
-- Hence, in this case, the following command will be used- DESCRIBE locations

    DESCRIBE locations;
    
--END OF FILE--

--Q5: Displaying Outputs based on Specified Queries, and prescribed conditions


SELECT location_id as city#, city as City, state_province|| ' IN THE ' ||country_id as "Province with Country Code"
FROM locations
--WHERE location_id <=1100;

--END OF FILE--

--END OF LAB1--

