-- ***********************
-- Name: Rohil Khakhar
-- ID: 109270173
-- Date: 15th November 2018
-- Date of Submission- 19th November 2018 
-- Purpose: Lab 9 DBS301
-- ***********************

--Lab9 Begins Now

--Q1: Table Creation 
--Solution:

CREATE TABLE SALESREP(
    RepId NUMBER (6) Primary Key, 
    FName VARCHAR2(20), 
    LName VARCHAR2(25) NOT NULL, 
    Phone# VARCHAR2(20), 
    Salary NUMBER (8, 2), 
    Commission NUMBER (2,2));

INSERT INTO SALESREP(
    SELECT employee_id, first_name, last_name, phone_number, salary, commission_pct
    FROM employees
    WHERE department_id = 80);

--End Of File

--Q2: Creating Another Table (LINK TO SALESREP, NOT EMPLOYEES.. change the REFERENCE section of the creation script)
--Solution:

CREATE TABLE Cust (
    Cust# NUMBER(6), 
    CustName VARCHAR2(30) NOT NULL, 
    City VARCHAR2(20) NOT NULL, 
    Rating CHAR(1), 
    Comments VARCHAR2(200), 
    SalesRep# NUMBER(7), 
    CONSTRAINT cust_cust#_pk PRIMARY KEY (Cust#), 
    CONSTRAINT cust_custname_city_uk UNIQUE (CustName, City), 
    CONSTRAINT cust_rating_ck CHECK (Rating IN ('A', 'B', 'C', 'D')),
    CONSTRAINT cust_salesrep#_fk FOREIGN KEY (SalesRep#)
        REFERENCES SALESREP (RepId));
    
--Now using INSERT for each of the values specified in the table

INSERT INTO Cust (cust#, custname, city, rating, salesrep#) 
VALUES (501, 'ABC LTD', 'Montreal', 'C', 149);

INSERT INTO Cust (cust#, custname, city, rating, salesrep#) 
VALUES (502, 'Black Giant', 'Ottawa', 'B', 174);

INSERT INTO Cust (cust#, custname, city, rating, salesrep#) 
VALUES (503, 'Mother Goose', 'London', 'B', 174);

INSERT INTO Cust (cust#, custname, city, rating, salesrep#) 
VALUES (701, 'BLUE SKY LTD', 'Vancouver', 'B', 176);

INSERT INTO Cust (cust#, custname, city, rating, salesrep#) 
VALUES (702, 'MIKE and SAM Inc.', 'Kingston', 'A', 174);

INSERT INTO Cust (cust#, custname, city, rating, salesrep#) 
VALUES (703, 'RED PLANET', 'Mississauga', 'C', 174);

INSERT INTO Cust (cust#, custname, city, rating, salesrep#) 
VALUES (717, 'BLUE SKY LTD', 'Regina', 'D', 176);

--End Of File

--Q3:Table Creation with specifications
--Solution:

CREATE TABLE GOODCUST (
    CustID, 
    Name, 
    Location, 
    RepId, 
    CONSTRAINT gcust_pk PRIMARY KEY (CustID))
    AS 
    (SELECT Cust#, CustName, City, SalesRep#
        FROM Cust
        WHERE rating IN('A', 'B'));
        
SELECT * FROM goodcust;
--testing purposes

ALTER TABLE goodcust
    ADD CONSTRAINT  gcust_fk FOREIGN KEY (RepId) REFERENCES Salesrep(RepId);

--End Of File

--Q4: Altering Columns
--Solution:

ALTER TABLE Salesrep
    ADD JobCode VARCHAR(12);
    
DESC Salesrep;
--Testing Purposes

--End Of File

--Q5: Column Alterations
--Solution:

ALTER TABLE Salesrep
    MODIFY Salary NOT NULL;
    
ALTER TABLE Goodcust
    MODIFY Location NULL;

ALTER TABLE Salesrep
    MODIFY fname VARCHAR (37);
    
--Maximum length of the Name stored in Goodcust- 17 (including spaces)    
SELECT MAX(LENGTH(name)) FROM goodcust; -- Length is an in-built function
   
ALTER TABLE goodcust
    MODIFY name VARCHAR(17);

--End Of File

--Q6: Getting Rid Of Columns
--Solution:

ALTER TABLE Salesrep
    SET UNUSED (JobCode); -- In a way that it doesnt affect everything else

--End Of File

--Q7 and 8: Constraint Settings
--Solution:

ALTER TABLE Salesrep
    ADD CONSTRAINT  sales_rep_uk UNIQUE (phone#,lname, fname);
    
--End Of File

--Q9: Restrictions
--Solution:

ALTER TABLE salesrep
    ADD CONSTRAINT sales_rep_ck CHECK (Salary BETWEEN 6000 AND 12000);

ALTER TABLE salesrep
    ADD CONSTRAINT commission_ck CHECK (Commission < 0.5);

--End Of File

--Q10: Validity Check
--Solution:

ALTER TABLE salesrep
    ADD CONSTRAINT rep_ck CHECK (Repid IS NOT NULL);
-- It worked... Interesting.....

--End Of File

--11, 12 are confusing

--Q13: Modification of yet more constraints
--Solution: 

ALTER TABLE salesrep
    ADD CONSTRAINT salary_rep_ck CHECK (Salary >= 5000 AND Salary <= 15000);

--End Of File

--Q14: Merely Describing Tables
--Solution:

SELECT constraint_name, constraint_type, search_condition, table_name
FROM user_constraints
WHERE table_name IN ('SALESREP', 'GOODCUST')
ORDER BY 4, 2;

--End Of File

--End Of Lab9
