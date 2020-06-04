--WEEK 7

--Part2- DBS 301

--SET OPERATORS AND CREATE REVIEW
--***************************************
--1. UNION
--2. INTERSECT
--3. MINUS
--4. UNION ALL - UNION will eliminate duplicates, UNION ALL WON'T

-- EXAMPLE 1: List all players whose last name starts with "st" or whose first name starts with "D"
--            DO NOT USE ANY COMPARATOR OPERATORS (no AND or OR)

--First- Just one half

SELECT * FROM tbldatplayers
    WHERE UPPER(namelast) LIKE 'ST%'
    ORDER BY namelast;
    --13 results

--now second part

SELECT * FROM tbldatplayers
    WHERE UPPER(namefirst) LIKE 'D%'
    ORDER BY namefirst;
    --53 results
    
--JOIN them TOGETHER using UNION

SELECT * FROM tbldatplayers
    WHERE UPPER(namelast) LIKE 'ST%'
       
    UNION
    
SELECT * FROM tbldatplayers
    WHERE UPPER(namefirst) LIKE 'D%';

--63 records, not 66.. Duplicate records are removed
--ORDER BY CANNOT BE USED WITH UNION

--But what if we need information about duplicate records
-- Use UNION ALL

SELECT * FROM tbldatplayers
    WHERE UPPER(namelast) LIKE 'ST%'
       
    UNION ALL
    
SELECT * FROM tbldatplayers
    WHERE UPPER(namefirst) LIKE 'D%';
    
    
-- But we need to order it
-- Use a subquery

SELECT * FROM 
    (SELECT * FROM tbldatplayers
    WHERE UPPER(namelast) LIKE 'ST%'
       
    UNION ALL
    
SELECT * FROM tbldatplayers
    WHERE UPPER(namefirst) LIKE 'D%')
ORDER BY namelast, namefirst;
    
--Combine this with aggregates
    
SELECT namelast, namefirst, COUNT(playerid) as NumRepeats FROM 
    (SELECT * FROM tbldatplayers
    WHERE UPPER(namelast) LIKE 'ST%'
       
    UNION ALL
    
SELECT * FROM tbldatplayers
    WHERE UPPER(namefirst) LIKE 'D%')
GROUP BY namelast, namefirst
ORDER BY NumRepeats DESC, namelast, namefirst;


--Example 2: List all teams that play today
--Update Data to make sure there is a game today

UPDATE tbldatgames SET gamedatetime = gamedatetime + 45;

SELECT hometeam, teamnameshort
    FROM tbldatgames JOIN tbldatteams
        ON tbldatgames.hometeam = tbldatteams.teamid
        WHERE gamedatetime BETWEEN sysdate -1 AND sysdate + 1;

--Now for visiting teams
    
SELECT visitteam, teamnameshort
    FROM tbldatgames JOIN tbldatteams
        ON tbldatgames.visitteam = tbldatteams.teamid
        WHERE gamedatetime BETWEEN sysdate -1 AND sysdate + 1;
    
--get all teams playing today

SELECT hometeam, teamnameshort
    FROM tbldatgames JOIN tbldatteams
        ON tbldatgames.hometeam = tbldatteams.teamid
        WHERE gamedatetime BETWEEN sysdate -1 AND sysdate + 1
        
    UNION
    
SELECT visitteam, teamnameshort
    FROM tbldatgames JOIN tbldatteams
        ON tbldatgames.visitteam = tbldatteams.teamid
        WHERE gamedatetime BETWEEN sysdate -1 AND sysdate + 1;

--****************************************************************
-- Now we want to know who is home and who is away

SELECT hometeam, teamnameshort, 'Home' AS HomeOrAway
    FROM tbldatgames JOIN tbldatteams
        ON tbldatgames.hometeam = tbldatteams.teamid
        WHERE gamedatetime BETWEEN sysdate -1 AND sysdate + 1
        
    UNION
    
SELECT visitteam, teamnameshort, 'Visitor' AS AwayorHome
    FROM tbldatgames JOIN tbldatteams
        ON tbldatgames.visitteam = tbldatteams.teamid
        WHERE gamedatetime BETWEEN sysdate -1 AND sysdate + 1;


--INTERSECT

SELECT namelast, namefirst, COUNT(playerid) as NumRepeats FROM 
    (SELECT * FROM tbldatplayers
    WHERE UPPER(namelast) LIKE 'ST%'
       
    INTERSECT
    
SELECT * FROM tbldatplayers
    WHERE UPPER(namefirst) LIKE 'D%')
    GROUP BY namelast, namefirst
    ORDER BY NumRepeats DESC, namelast, namefirst;
    
    
--MINUS

SELECT namelast, namefirst, COUNT(playerid) as NumRepeats FROM 
    (SELECT * FROM tbldatplayers
    WHERE UPPER(namelast) LIKE 'ST%'
       
    MINUS
    
SELECT * FROM tbldatplayers
    WHERE UPPER(namefirst) LIKE 'D%')
    GROUP BY namelast, namefirst
    ORDER BY NumRepeats DESC, namelast, namefirst;
--Gives 13-3 = 10 results (excluding duplicates)


--*************************************
--CREATE REVIEW
--*************************************

--Constraints
--1. PRIMARY KEY
--2. FOREIGN KEY
--3. NOT NULL
--4. UNIQUE
--5. DEFAULT
--6. CHECK
--7. INDEXES

--Generic Format

--CREATE TABLE table_name (
--    column1 datatype<constraint1> <constraint2>...,
--    column2 datatype<constraint1> <constraint2>...,
--    column3 datatype<constraint1> <constraint2>...,
--   ....
--);

CREATE TABLE tblListLocations (

    locationid INT PRIMARY KEY, 
    locationName varchar(50) NOT NULL, 
    fieldlength INT CHECK (fieldlength BETWEEN 100 AND 110));
   
    
    
























