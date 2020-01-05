DROP DATABASE Empire;
CREATE DATABASE Empire;
USE Empire;

CREATE TABLE Planet(
Planet_ID INT NOT NULL PRIMARY KEY,
Planet_Name VARCHAR(50),
GSN INT NOT NULL,
Solarsystem VARCHAR(50)
);

CREATE TABLE ResearchCentre (
    Centre_ID INT NOT NULL PRIMARY KEY,
    Street_address VARCHAR(200),
    Postal_address VARCHAR(200),
    Planet_ID INT NOT NULL REFERENCES Planet(Planet_ID),
    Project_ID INT NOT NULL REFERENCES Project (Project_ID)
);
	
CREATE TABLE Section (
    Section_ID INT NOT NULL PRIMARY KEY,
    Section_name VARCHAR(50) NOT NULL,
    Centre_ID INT NOT NULL REFERENCES ResearchCentre (Centre_ID)
);

CREATE TABLE Scientist (
    Employee_ID INT NOT NULL PRIMARY KEY,
    Employee_Name VARCHAR(50),
    Monthly_salary INT NOT NULL,
    Phone_number VARCHAR(50) NOT NULL,
    Birthdate DATE,
    Is_Traitor BOOLEAN NOT NULL,
    Is_Chief BOOLEAN NOT NULL,
    ManagerID INT,
    Section_ID INT REFERENCES Section (Section_ID)
);
CREATE TABLE Superweapon (
    Project_ID INT NOT NULL PRIMARY KEY,
    Date_of_commencement DATETIME,
    Target_ID INT NOT NULL REFERENCES Target (Target_ID),
	Centre_ID INT NOT NULL REFERENCES ResearchCentre(Centre_ID)
);
CREATE TABLE Flaw (
    Flaw_ID INT NOT NULL PRIMARY KEY,
    Description VARCHAR(200),
    Date_Introduced DATETIME,
    Is_Critical BOOLEAN NOT NULL,
    Employee_ID INT NOT NULL REFERENCES FlawScientist (Employee_ID),
	Project_ID INT NOT NULL REFERENCES Superweapon(Project_ID)
);

CREATE TABLE Target (
    Target_ID INT NOT NULL PRIMARY KEY,
    Target_name VARCHAR(50)
);

CREATE TABLE Statuses (
    Status_ID INT NOT NULL PRIMARY KEY auto_increment,
    Status_name VARCHAR(50)
);

CREATE TABLE ProjectPhases (
    Status_ID INT NOT NULL REFERENCES Statuses(Status_ID),
	Duration INT,
	CurrentPhase BOOLEAN DEFAULT FALSE,
	Project_ID INT NOT NULL REFERENCES Superweapon(Project_ID),
	PRIMARY KEY(Status_ID, Project_ID)
);

CREATE TABLE Componants (
    Componant_ID INT NOT NULL PRIMARY KEY,
    Componant_Name VARCHAR(50),
    Cost FLOAT,
	Project_ID INT NOT NULL REFERENCES Superweapon(Project_ID)
);

INSERT INTO
Planet(Planet_ID,Solarsystem,Planet_Name,GSN)
VALUES
(1,'Milkyway','Mars',1101),
(2,'Milkyway','Alphacentury',1101),
(3,'Milkyway','Deltac',1101),
(4,'Milkyway','Charlieb',1101),
(5,'Milkyway','PlanetC',1101),
(6,'Milkyway','DeltaB',1101),
(7,'Milkyway','Earth',1101);

INSERT INTO 
ResearchCentre(Centre_ID, Street_address, Postal_address,Planet_ID, Project_ID)
VALUES
(101,'3 Dog St Nedlands', '4 Big road Subiaco',1,1222),
(102,'36 Stan Rd Cottesloe', '5 Small lane Subiaco', 2,1223),
(103,'44 Nathan Rd Dalkeith', '7 Low avenue City Beach',3,1224),
(104,'53 Selby St Floreat', '4 Olive street Subiaco',4,1225),
(105,'75 John Rd Karakatta', '15 High avenue Subiaco',  5,1226),
(106,'34 Right Rd Nedlands', '33 Large avenue Subiaco', 1,1227),
(107,'44 John St Daglish', '23 Sith lane Claremont', 2,1228),
(108,'63 Davies Rd Claremont', '34 Thomas steet Nedlands', 1,1229),
(109,'44 John St Daglish', '23 Sith lane Claremont', 6,1230),
(110,'63 Johnston Rd Cannington', '56 Luke steet Armadale', 7,1231);

INSERT INTO 
 Scientist(Employee_ID,Employee_Name,Monthly_salary,Phone_number,Birthdate,Is_Traitor, Is_Chief,ManagerID,Section_ID)
VALUES
 (2,'Jack AB',4000,'50002224','1986-01-22',FALSE,TRUE,null,230),
 (3,'Jack AC',2000,'50002226','1972-01-22',FALSE,FALSE,2,230),
 (4,'Jack AD',3000,'50002227','1957-01-21',TRUE,FALSE,2,230),
 (5,'Jack AE',5000,'50002228','1967-04-22',TRUE,TRUE,null,231),
 (6,'Jack AF',2000,'50002229','1995-01-23',FALSE,FALSE,5,231),
 (7,'Jack AG',4400,'50002230','1969-04-22',FALSE,FALSE,5,231),
 (8,'Jack AH',3500,'50002230','1970-04-23',FALSE,FALSE,null,233),
 (9,'Jack AI',2300,'50002231','1975-04-24',FALSE,FALSE,8,233),
 (10,'Jack AJ',3900,'50002262','1978-05-19',FALSE,FALSE,8,233),
 (11,'Jack AK',3400,'50002263','1975-05-19',FALSE,FALSE,8,233);

INSERT INTO 
Superweapon(Project_ID,Date_of_commencement,Target_ID,Centre_ID)
VALUES
 (1222,'2014-01-22 10:00:00.000',2,101),
 (1223,'2015-06-20 10:00:00.000',3,102),
 (1224,'2013-06-14 10:00:00.000',2,103),
 (1225,'2014-01-14 10:00:00.000',1,104),
 (1226,'2011-04-11 10:00:00.000',3,105),
 (1227,'2013-07-18 10:00:00.000',1,106),
 (1228,'2011-03-13 10:00:00.000',2,107),
 (1229,'2013-09-11 10:00:00.000',3,109),
 (1230,'2014-05-10 10:00:00.000',1,110),
 (1231,'2012-09-17 10:00:00.000',2,111);

INSERT INTO 
Section(Section_ID,Section_name,Centre_ID)
VALUES
 (230,'S1',101),
 (231,'S2',102),
 (232,'S3',103),
 (233,'S4',104),
 (234,'S5',105),
 (235,'S6',106),
 (236,'S7',107),
 (237,'S8',108),
 (238,'S9',109),
 (239,'S10',110);

INSERT INTO
Target(Target_ID,Target_Name)
VALUES
 (1,'Continent'),
 (2,'Planet'),
 (3,'Solarsystem');

INSERT INTO
Statuses(Status_name)
VALUES
 ('Analysis'),
 ('Design'),
 ('In Development'),
 ('Tested'),
 ('Delivered'),
 ('Deployed'),
 ('Destroyed');

INSERT INTO ProjectPhases(Status_ID, Duration, Project_ID)
VALUES
(1,13,1222),
(1,15,1223),
(1,11,1224),
(1,10,1225),
(1,18,1226),
(2,14,1227),
(2,17,1228),
(2,12,1229),
(2,15,1230),
(2,17,1231),
(2,14,1223),
(3,11,1227),
(3,14,1228),
(4,17,1227),
(4,12,1228),
(5,15,1227),
(5,17,1228),
(6,14,1227),
(7,11,1227);

INSERT INTO ProjectPhases(Status_ID, Duration, Project_ID, CurrentPhase)
VALUES
 (3, NULL, 1229, True), 
 (3, NULL, 1230, True),
 (2, NULL, 1225, True);

INSERT INTO
Componants(Componant_ID,Componant_Name,Cost,Project_ID)
VALUES
 (120,'Sparkplug',12.45,1222),
 (121,'Spanner',12.55,1222),
 (122,'Nut',9.15,1223),
 (123,'Pipe',22.95,1225),
 (124,'Elbow',44.35,1226),
 (125,'Sink',100.95,1224),
 (126,'Hammer',34.55,1223),
 (128,'Drill',22.56,1226),
 (129,'Barrier',33.67,1230),
 (130,'Computer',55.67,1231);

INSERT INTO
Flaw(Flaw_ID,Description,Date_Introduced,Is_Critical,Employee_ID,Project_ID)
VALUES
 (1,'Broken Window','2017-11-17',FALSE,2,1222),
 (2,'Punctured Tyre','2017-12-18',FALSE,2,1222),
 (3,'Malfunctioning Lever','2019-01-15',FALSE,4,1226),
 (4,'Cracked Oil Gasket','2019-01-12',TRUE,6,1227),
 (5,'Rusted Chasis','2018-12-19',TRUE,7,1227),
 (6,'Loose Connection','2019-01-15',FALSE,5,1228),
 (7,'Loose Gaskett','2019-01-14',TRUE,3,1228),
 (8,'Loose Level','2019-01-14',TRUE,4,1228);
######################################
#QUERIES


SHOW FULL PROCESSLIST