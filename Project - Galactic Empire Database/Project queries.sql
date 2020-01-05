

-- 1 
#Assume non-chief scientists have the same section_ID as their manager.
#There are only 10 Scentists, as a result- some research centres are currently vacant.
SELECT S.Employee_Name, RC.Centre_ID,RC.Postal_address FROM Scientist S INNER JOIN Section C ON C.Section_ID = S.Section_ID
	INNER JOIN ResearchCentre RC ON RC.Centre_ID = C.Centre_ID;

-- 2 
#If Manager_ID and Manager_Name is NULL then they are considered a Chief Scientist
SELECT S1.Employee_Name,S1.Employee_ID,S2.Employee_Name AS 'Manager_Name',S2.Employee_ID AS 'Manager_Name'
	FROM Scientist S1 LEFT OUTER JOIN Scientist S2 
	ON S1.ManagerID = S2.Employee_ID;


-- 3
SELECT P.Planet_ID,P.Planet_Name, Count(*) AS '#_of_centres' FROM ResearchCentre R 
    JOIN Planet P ON R.Planet_ID = P.Planet_ID 
    GROUP BY P.Planet_ID ORDER BY COUNT(*) DESC LIMIT 1;

-- 4
SELECT S.Employee_ID,S.Employee_Name
	FROM Scientist S LEFT JOIN 
	(SELECT S2.Employee_ID, Flaw_ID FROM Scientist S2
		INNER JOIN Flaw ON S2.Employee_ID = Flaw.Employee_ID
        WHERE Date_Introduced > '2019-01-01' ) F
		ON S.Employee_ID = F.Employee_ID 
		WHERE F.Flaw_ID IS NULL;

-- 5 
#This question is ambiguous - My interpretation is that time spent 
#on projects is equal sum of the duration of time spent on each phase for every project. 
#The answer is therefore the average of time spent
SELECT AVG(Total_Duration) AS 'Avg Duration' FROM (
	SELECT SW.Project_ID, SUM(Duration) AS Total_Duration FROM Superweapon SW
	INNER JOIN ProjectPhases PP ON SW.Project_ID = PP.Project_id
	GROUP BY SW.Project_ID) innerQuery;

-- 6 #Safemde (Safe Updates) must be disabled for this query to run.
SET SQL_SAFE_UPDATES = 0;
UPDATE Scientist S  
	INNER JOIN Flaw F ON S.Employee_ID = F.Employee_ID 
	AND F.Is_Critical = TRUE 
	AND F.Date_Introduced > '2018-02-01'
	SET S.Monthly_salary = round(S.Monthly_salary*1.10, 0);
SET SQL_SAFE_UPDATES = 1;

-- 7
#My interpretation of this question is that we are looking for ONLY non-chief scientists 
#who have introduced critical flaws
#"Find the names, ID's and number of staff supervised of the Chief Scientist *WHOSE*
#scientists have incorporated the most critical flaws.."
SELECT S.ManagerID,S1.Employee_Name AS 'Manager_Name' , COUNT(DISTINCT S.Employee_ID) as manager_num_of_employees
FROM Scientist S
INNER JOIN Flaw F on F.Employee_ID = S.Employee_ID 
INNER JOIN ProjectPhases PP ON PP.Project_ID = F.Project_ID
INNER JOIN Scientist S1 ON S.ManagerID = S1.Employee_ID
WHERE Is_Critical = TRUE AND Status_ID >=5
GROUP BY S.ManagerID, S1.Employee_Name LIMIT 3;
