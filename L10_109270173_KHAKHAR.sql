-- ***********************
-- Name: Rohil Khakhar
-- ID: 109270173
-- Date: 26th November 2018
-- Date of Submission- 26th November 2018 
-- Purpose: Lab 10 DBS301
-- ***********************

--Lab10 Begins Now

--Q1: Create Table 'AS'
--Solution:

CREATE TABLE CITIES AS (
    SELECT * FROM locations
    WHERE location_id <2000);

DESC cities;

--End Of File

--Q2: Creating another Table
--Solution:

CREATE TABLE TOWNS AS (
    SELECT * FROM locations
    WHERE location_id <1500);

DESC towns;

--End Of File

--Q3: Emptying the recycle bin
--Solution:

SHOW RecycleBin;
--PURGE table TOWNS;
--Now, Remove Contents of the Recycle Bin

PURGE  RECYCLEBIN;

--savepoint a;

DROP TABLE towns;

DESC towns;

--Purge, Flashback;

--End Of File

--Q4: Recovery Process
--Solution:

--Now Recover it
FLASHBACK TABLE towns to BEFORE DROP; -- table will now be retrieved

DESC towns;

SHOW RecycleBin;

--End Of File


--Q5: Dropping tables again
--Solution:

DROP TABLE towns;
FLASHBACK TABLE towns to BEFORE DROP;
--It succeeds for some reason

SELECT * FROM RecycleBin;
--An empty table is shown
DESC RecycleBin;

--End Of File

--Q6: Creating some views
--Solution:

SELECT  * FROM cities;
--For testing purposes

CREATE VIEW CAN_CITY_VU AS
    SELECT street_address, postal_code, city, state_province 
    FROM cities
            WHERE country_id = 'CA';
            
SELECT * FROM can_city_vu;
--display data from the view
            
--End Of File

--Q7: Modifications to the SIMPLE view
--Solution:

CREATE OR REPLACE VIEW CAN_CITY_VU AS
    SELECT street_address Str_Adr, postal_code P_Code, city City, state_province Prov 
    FROM cities
            WHERE country_id IN ('CA', 'IT');
            
SELECT * FROM can_city_vu;

--End Of File

--Q8: COMPLEX VIEWS
--Solution:

CREATE VIEW CITY_DNAME_VU AS
    SELECT d.department_name, l.city, l.state_province
    FROM departments d RIGHT OUTER JOIN locations l
            ON(d.location_id= l.location_id)
                WHERE country_id IN ('CA', 'IT');

SELECT * FROM CITY_DNAME_VU;

--End Of File

--Q9: Modifying this complex view
--Solution:

--testing purposes
--select * from locations

CREATE OR REPLACE VIEW CITY_DNAME_VU AS
    SELECT d.department_name DName, l.city City, l.state_province Prov
    FROM departments d RIGHT OUTER JOIN locations l
            ON(d.location_id= l.location_id)
                WHERE country_id IN ('CA', 'IT') 
                AND country_id NOT IN ('US');

SELECT * FROM CITY_DNAME_VU;

--End Of File

--Q10: Data Dictionary
--Solution:

SELECT * FROM ALL_VIEWS;
SELECT * FROM USER_VIEWS;

DROP view city_dname_vu;
--successfully dropped
--one less view displayed in the following select statement
SELECT * FROM USER_VIEWS;

--End Of File

--End Of Lab10

