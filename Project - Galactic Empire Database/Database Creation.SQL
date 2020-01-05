Creating tables
DROP DATABASE Empire;
CREATE DATABASE Empire;
USE DATABASE Empire;

CREATE TABLE Research_Centre(
    Centre_ID INT NOT NULL PRIMARY KEY,
    Street_address VARCHAR(200),
    Postal_address VARCHAR(200),
    Galatic_sector_number INT NOT NULL;
    Solarsystem VARCHAR(100),
    Planet VARCHAR(50),
    
);
CREATE TABLE Section(
    Section_ID INT NOT NULL PRIMARY KEY,
    Section_name VARCHAR(50),
    Centre_ID FOREIGN KEY,
    REFERENCES Research_Centre(Centre_ID)
);

CREATE TABLE Scientist(
    Employee_ID INT NOT NULL PRIMARY KEY,
    Employee_Name VARCHAR(50),
    Monthly_salary INT NOT NULL,
    Telephone_number INT NOT NULL,

)

CREATE TABLE Chief_scientist(
    Employee_ID INT FOREIGN KEY,

)

CREATE TABLE Superweapon(
    Project_ID INT NOT NULL PRIMARY KEY,
    Date_of_commencement DATETIME,
    
)

CREATE TABLE Flaw(
    Is_major BOOLEAN,
    Is_critical BOOLEAN,
    )

CREATE TABLE Major_flaw(
    Is_major BOOLEAN,
    Flaw_description varchar(500),
    Date_of_introduction DATETIME,
    Employee_ID INT NOT NULL FOREIGN KEY
)
CREATE TABLE Critical_flaw(
    Is_critical BOOLEAN,
    Flaw_description varchar(500),
    Date_of_introduction DATETIME,
    Employee_ID INT NOT NULL FOREIGN KEY
)
