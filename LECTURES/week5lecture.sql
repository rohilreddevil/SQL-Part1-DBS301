--WEEK5 Lecture- Joins
--Using the sportleagues database
--October 1, 2018

SELECT * FROM tbldatplayers;

SELECT COUNT(teamid) FROM tbldatteams;

SELECT * FROM tbljncrosters;
SELECT COUNT(rosterid) FROM tbljncrosters;

SELECT COUNT (Distinct playerID ) FROM tbljncrosters;

--show some names
SELECT rosterid, tbldatplayers.playerid, teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast
FROM tbljncrosters, tbldatplayers;

--this simple join assumes relationship between each record in each table
-- we get 595*230 records --> USELESS

--DBS201 WHERE CLAUSE
SELECT rosterid, tbldatplayers.playerid, teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast
FROM tbljncrosters, tbldatplayers
WHERE tbldatplayers.playerid = tbljncrosters.playerid;

--let's use joins
--GENERIC FORMAT

--SELECT <fields>
--  FROM <table1> <jointype> JOIN <table2>
--      ON <table1.fieldname> = <table2.fieldname>
--  WHERE ...
--  GROUP BY..
--  HAVING ...
--  ORDER BY...

-- 4 types of Joins
--  1. Full Join
--  2. Inner Join -- very commonly used .. the default join if the joint type is not specified
--  3. Left Outer Join
--  4. Right Outer Join

SELECT rosterid, tbldatplayers.playerid, teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast
FROM tbljncrosters INNER JOIN tbldatplayers
    ON tbldatplayers.playerid = tbljncrosters.playerid; --INSTEAD OF the WHERE CLAUSE

--**********************************************************************************************
--when you do an inner join, it will give you the records from each table but ONLY IF THEY MATCH
--**********************************************************************************************

--Lets show all player regardless if they are on the team or not, but we still want to see the teamnames for those on a team
SELECT rosterid, tbldatplayers.playerid, teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast
FROM tbljncrosters RIGHT OUTER JOIN tbldatplayers
    ON tbldatplayers.playerid = tbljncrosters.playerid
    ORDER BY teamid DESC;
    --this includes all records from the RIGHT table(players) and only those from teams where playerid's match 
    
--prioritize the RIGHT HAND SIDE TABLE (tbldatplayers)
--prioritize the LEFT HAND SIDE TABLE (LEFT OUTER JOIN)
--prioritize BOTH TABLES (FULL OUTER JOIN)

--lets invest in LEFT OUTER JOIN
SELECT rosterid, tbldatplayers.playerid, teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast
FROM tbljncrosters LEFT OUTER JOIN tbldatplayers
    ON tbldatplayers.playerid = tbljncrosters.playerid
    ORDER BY teamid DESC;
--prioritizes the left side based on the ON clause

--lets see all records from BOTH tables
SELECT rosterid, tbldatplayers.playerid, teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast
FROM tbljncrosters FULL OUTER JOIN tbldatplayers
    ON tbldatplayers.playerid = tbljncrosters.playerid
    ORDER BY teamid DESC;

--lets display ALL players NOT on a roster
SELECT rosterid, tbldatplayers.playerid, teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast
FROM tbljncrosters RIGHT OUTER JOIN tbldatplayers
    ON tbldatplayers.playerid = tbljncrosters.playerid
    WHERE rosterid IS NULL --filter out the players who have rosterid's
    ORDER BY teamid DESC;

--show rosters displaying team names and player names
SELECT rosterid, tbldatplayers.playerid, tbldatteams.teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast, teamnameshort
FROM (tbljncrosters LEFT OUTER JOIN tbldatplayers --prioritize all players with a roster
    ON tbldatplayers.playerid = tbljncrosters.playerid)
        LEFT OUTER JOIN tbldatteams
            ON tbljncrosters.teamid = tbldattteams.teamid
ORDER BY teamnameshort, namelast, namefirst;

--lets output only 1 team
SELECT rosterid, tbldatplayers.playerid, tbldatteams.teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast, teamnameshort
FROM (tbljncrosters LEFT OUTER JOIN tbldatplayers --prioritize all players with a roster
    ON tbldatplayers.playerid = tbljncrosters.playerid)
        LEFT OUTER JOIN tbldatteams
            ON tbljncrosters.teamid = tbldattteams.teamid
WHERE tbljncrosters.teamid= 214 -- id specific
ORDER BY teamnameshort, namelast, namefirst;

--but i want to choose different teams
SELECT rosterid, tbldatplayers.playerid, tbldatteams.teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast, teamnameshort
FROM (tbljncrosters LEFT OUTER JOIN tbldatplayers --prioritize all players with a roster
    ON tbldatplayers.playerid = tbljncrosters.playerid)
        LEFT OUTER JOIN tbldatteams
            ON tbljncrosters.teamid = tbldattteams.teamid
WHERE tbljncrosters.teamid= &teamid -- prompt the user to inout a value for the team id
ORDER BY teamnameshort, namelast, namefirst;

--BUT i don't know the team id
SELECT rosterid, tbldatplayers.playerid, tbldatteams.teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast, teamnameshort
FROM (tbljncrosters LEFT OUTER JOIN tbldatplayers --prioritize all players with a roster
    ON tbldatplayers.playerid = tbljncrosters.playerid)
        LEFT OUTER JOIN tbldatteams
            ON tbljncrosters.teamid = tbldattteams.teamid
WHERE UPPER(teamnameshort)= UPPER ('&teamname') 
ORDER BY teamnameshort, namelast, namefirst;

--We don't know how to spell
SELECT rosterid, tbldatplayers.playerid, tbldatteams.teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast, teamnameshort
FROM (tbljncrosters LEFT OUTER JOIN tbldatplayers --prioritize all players with a roster
    ON tbldatplayers.playerid = tbljncrosters.playerid)
        INNER JOIN tbldatteams
            ON tbljncrosters.teamid = tbldattteams.teamid
WHERE UPPER(tbldattteams.teamnameshort) LIKE UPPER('%&Teamname%') 
ORDER BY teamnameshort, namelast, namefirst;

--WE CAN USE ALIASES for tables
SELECT rosterid, tbldatplayers.playerid, tbldatteams.teamid, tbljncrosters.isactive, jerseynumber, namefirst, namelast, 
teamnameshort
FROM (tbldatteams t INNER JOIN tbljncrosters r --prioritize all players with a roster
    ON t.teamid = r.teamid)
        INNER JOIN tbldatplayers p 
            ON p.playerid = r.playerid
            
WHERE UPPER(tbldattteams.teamnameshort) LIKE UPPER('%&Teamname%') 
ORDER BY teamnameshort, namelast, namefirst;








