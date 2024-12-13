CREATE DATABASE cs_mock;
USE cs_mock;


CREATE TABLE Organizers (
    Organizer_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email_Address VARCHAR(255),
    Contact_ID INT,
    Address_ID INT,
    Web_Site_Address VARCHAR(255),
    Mobile_Number VARCHAR(20)
);

CREATE TABLE Ref_Event_Status (
    Event_Status_Code INT PRIMARY KEY,
    Event_Status_Description VARCHAR(255)
);

CREATE TABLE Ref_Event_Types (
    Event_Type_Code INT PRIMARY KEY,
    Event_Type_Description VARCHAR(255)
);

CREATE TABLE Venues (
    Venue_ID INT PRIMARY KEY,
    Venue_Name VARCHAR(255),
    Other_Details TEXT
);
CREATE TABLE Events (
    Event_ID INT PRIMARY KEY,
    Event_Status_Code INT,
    Event_Type_Code INT,
    Organizer_ID INT,
    Venue_ID INT,
    Event_Name VARCHAR(255),
    Event_Start_Date DATE,
    Event_End_Date DATE,
    Number_of_Participants INT,
    Event_Duration VARCHAR(255),
    Potential_Cost DECIMAL(10, 2),
    FOREIGN KEY (Event_Status_Code) REFERENCES Ref_Event_Status(Event_Status_Code),
    FOREIGN KEY (Event_Type_Code) REFERENCES Ref_Event_Types(Event_Type_Code),
    FOREIGN KEY (Organizer_ID) REFERENCES Organizers(Organizer_ID),
    FOREIGN KEY (Venue_ID) REFERENCES Venues(Venue_ID)
);
