------------------------------------------------------------------------------
-- Week 6 Working Demo
-- Working examples of Weeks 1 - 6
-- Review for Midterm Test
------------------------------------------------------------------------------
-- Using Sportleagues Tables (start with "TBL")

------------------------------------------------------------------------------
-- Week 1 review (Select, Order By, Formatting)

------------------------------------------------------------------------------
-- Q1:  A soccer ball was left on the field after a tournament involving 
--      all teams and players.  The ball had the name Paul on it.  Create a 
--      statement that lists all players first name, last name and registration
--      number whom have the first name "Paul".  List only active players and 
--      sort them by last name.

SELECT namefirst, namelast, regnumber
    FROM tbldatplayers
    WHERE UPPER(namefirst) = 'PAUL' AND ISACTIVE=1
    ORDER BY namelast;
    
    -- maybe we need to type in the name
SELECT namefirst, namelast, regnumber
    FROM tbldatplayers
    WHERE UPPER(namefirst) = UPPER('&Name') AND ISACTIVE=1
    ORDER BY namelast; 
------------------------------------------------------------------------------
-- Q2:  Provide a list of teams for the current season (i.e. active teams) and 
--      their shirt colours such that we can ensure that games can be played 
--      without both teams wearing the same colour.  
--      Provide Aliases and sorting as appropriate.

SELECT  teamid AS "ID",
        teamnamelong AS "Team",
        uniformcolour AS "Colour"
    FROM tbldatteams
    WHERE isactive = 1
    ORDER BY teamnamelong;
    
------------------------------------------------------------------------------
-- Week 2 - advanced SELECT
------------------------------------------------------------------------------
-- Q3:  Provide a schedule for all games played in the month of July.  Include 
--      the game number, two teamid's, date, locationid, and notes.  Sort the games by date
--      first and then game number.  Provide appropriate aliases.

SELECT  gamenum AS "Game#",
        gamedatetime AS "Date",
        hometeam AS "Home",
        visitteam AS "Visitor",
        locationid AS "LocID",
        notes AS "Notes"
    FROM tbldatgames
    WHERE gamedatetime BETWEEN to_date('170701', 'yymmdd') AND to_date('170801', 'yymmdd')
    ORDER BY gamedatetime, gamenum;
    
------------------------------------------------------------------------------
-- Q4:  SINGLE FUNCTION and JOINS
--      It's awards time and we want to display the player who scored the most 
--      goals in a single game.  List all players whom scored at least 4 goals 
--      in a single game in order of goals scored DESC.  Show the player
--      first and last name in a single field, the team name that they play for 
--      and the number of goals scored.

SELECT  namefirst || ' ' || namelast AS "Player",
        teamnamelong AS "Team",
        numgoals AS "# Goals"
    FROM tbldatplayers JOIN tbldatgoalscorers USING (playerID)
        JOIN tbldatteams USING (teamid)
    WHERE numgoals >= 4
    ORDER BY numgoals DESC;

------------------------------------------------------------------------------

        
        