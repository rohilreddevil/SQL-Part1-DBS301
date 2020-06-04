--Lecture 6
--SUBQUERIES (sub SELECT)- ability to use SELECT more than once
--Types of Queries-
--  1. Tabular- returns a table with columns and rows
--  2. Scalar- returns a SINGLE value, string, etc


-- What was the most goals scored in one game by a single player ??

SELECT MAX(NumGoals) AS "Num Goals"
FROM tbldatgoalscorers;

-- What is the player ID of the player in the previous example( sub select)

SELECT DISTINCT playerID -- Distinct so if the same player did it twice, we dont see it 
    FROM tbldatgoalscorers
    WHERE NumGoals = (SELECT MAX(NumGoals)  --sub-select will happen first due to brackets
FROM tbldatgoalscorers);
--this has happened 4 times 
--After the '=', sub query must be scalar (NO TABLE QUERY SHOULD BE THERE AFTER THE = )

--But we need NAMES

SELECT nameFirst, nameLast
    FROM tbldatplayers
    WHERE playerID IN (SELECT DISTINCT playerID -- Distinct so if the same player did it twice, we dont see it 
                        FROM tbldatgoalscorers
                        WHERE NumGoals = (SELECT MAX(NumGoals) AS "Num Goals"  --sub-select will happen first due to brackets
                                            FROM tbldatgoalscorers));
                            
--ANOTHER WAY TO DO THIS (see below)

SELECT nameFirst, nameLast, (SELECT MAX(NumGoals) FROM tbldatgoalscorers) AS "Num Goals"
    FROM tbldatplayers
    WHERE playerID IN (SELECT DISTINCT playerID -- Distinct so if the same player did it twice, we dont see it 
                        FROM tbldatgoalscorers
                        WHERE NumGoals = (SELECT MAX(NumGoals) AS "Num Goals"  --sub-select will happen first due to brackets
                                            FROM tbldatgoalscorers))
    ORDER BY nameFirst, nameLast;


-- List all employees that work in Seattle (Do not Use Joints)
--First find the locationid for seattle

SELECT location_id 
    FROM locations
    WHERE UPPER(city) LIKE 'SEATTLE';
--Note: THIS IS SCALAR now BUT could be a list, therefore TABULAR of sub-type LIST
--Now we have to find the departments that are in Seattle
SELECT DISTINCT department_id  
    FROM departments
    WHERE location_id IN (SELECT location_id 
                            FROM locations
                            WHERE UPPER(city) LIKE 'SEATTLE');

--We still dont have the list of employees
--Get employees from department id's

SELECT  first_name, last_name
    FROM employees
    WHERE department_id in (SELECT DISTINCT department_id  
                            FROM departments
                            WHERE location_id IN (SELECT location_id 
                                FROM locations
                                    WHERE UPPER(city) LIKE 'SEATTLE'))
ORDER BY first_name, last_name;

--How do we double check this??

--Lets create the league schedule for sportsleagues

SELECT gameid, gamenum, hometeam AS hometeamid, hteam.teamnameshort AS HometeamName, visitteam AS VisitTeamID, 
        vteam.teamnameshort AS VisitTeamName, locationid, gamedatetime
    FROM (tbldatgames game JOIN tbldatteams hteam 
        ON game.hometeam = hteam.teamid)
        JOIN tbldatteams vteam
            ON game.visitteam= vteam.teamid
    ORDER BY gamedatetime;

------------------------------------------------------------------------------------------------------------------







