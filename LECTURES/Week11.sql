--Week11
--Transactions

CREATE TABLE tblDatPlayoffGames AS (
    SELECT gameID poGameID, gameNum, hometeam hTeamID, visitteam vTeamID, homescore, visitscore, locationid,
    isplayed, notes
    FROM tbldatgames
    WHERE divid IN (30));
    
ALTER TABLE tblDatPlayoffGames 
    ADD CONSTRAINT tblgamepo_pk PRIMARY KEY (poGameID);
    
--'CREATE AS' can use fields from multiple fields

SELECT gameID poGameID, gameNum, h.teamnameshort HomeTeam, v.teamnameshort AwayTeam, homescore, visitscore, locationid,
isplayed, notes
FROM tbldatgames JOIN tbldatteams h ON h.teamid = tbldatgames.hometeam 
    JOIN tbldatteams v ON v.teamid = tbldatgames.visitteam
WHERE divid IN (30);

CREATE TABLE tblTEMPdatPOSchedule AS (
    SELECT gameID poGameID, gameNum, h.teamnameshort HomeTeam, v.teamnameshort AwayTeam, homescore, visitscore, locationid,
isplayed, notes
FROM tbldatgames JOIN tbldatteams h ON h.teamid = tbldatgames.hometeam 
    JOIN tbldatteams v ON v.teamid = tbldatgames.visitteam
WHERE divid IN (30));

--TRANSACTIONS
--SQL SERVER

--START TRANSACTION
--Do Stuff
--END TRANSACTION
--COMMIT

--IN ORACLE
--3 Keywords
--  COMMIT - No Undo once committed
--  ROLLBACK - Application before committing
--  SAVEPOINT

--ROLLBACK AND COMMIT ONLY APPLIES TO DML (Data Manipulation)
--DML- INSERT, UPDATE, ETC

INSERT INTO tbldatplayers VALUES (99988, '431', 'Manchesterrr', 'Rohil', 1);

SELECT * FROM tbldatplayers WHERE playerid = 99988;

ROLLBACK; 
--Now when you run the SELECT statement, no value displayed
--ROLLBACK will undo everything since the last COMMIT
SELECT * FROM tbldatplayers WHERE playerid = 99988;
INSERT INTO tbldatplayers VALUES (99988, '431', 'Manchesterrr', 'Rohil', 1);
SELECT * FROM tbldatplayers WHERE playerid = 99988;
INSERT INTO tbldatplayers VALUES (99988, '431', 'Manchesterrr', 'Rohil', 1);
COMMIT;
SELECT * FROM tbldatplayers WHERE playerid = 99988;
ROLLBACK;
SELECT * FROM tbldatplayers WHERE playerid = 99988; --THIS DATA WILL STILL BE THERE

-- Trade 2 players between 2 teams

SELECT * FROM tbljncrosters 
WHERE playerid IN (1019404, 1746230);

UPDATE tbljncrosters
SET teamid = 221
WHERE rosterid = 4;

SAVEPOINT a; --Choose where the ROLLBACK will go to

UPDATE tbljncrosters
SET teamid = 214
WHERE rosterid= 14;

SELECT * FROM tbljncrosters 
WHERE playerid IN (1019404, 1746230);
ROLLBACK; --Undone.. Hence Transaction starts again
ROLLBACK to a; -- Both players in 221 teamid.. Undoes the log to the savepoint.. DOES NOT START A NEW TRANSACTION
ROLLBACK;


--Let us test ROLLBACK across a COMMIT using a savepoint

SAVEPOINT b;

UPDATE tbljncrosters
SET teamid = 221
WHERE rosterid = 4;

COMMIT; -- Deletes all Savepoints
ROLLBACK TO b;
