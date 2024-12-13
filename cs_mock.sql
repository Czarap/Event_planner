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

INSERT INTO Organizers (Organizer_ID, Name, Email_Address, Contact_ID, Address_ID, Web_Site_Address, Mobile_Number) VALUES
(1, 'Mock Organizer One', 'mock1@example.com', 301, 401, 'www.mock1.com', '9876543210'),
(2, 'Mock Organizer Two', 'mock2@example.com', 302, 402, 'www.mock2.com', '9876543211'),
(3, 'Mock Organizer Three', 'mock3@example.com', 303, 403, 'www.mock3.com', '9876543212'),
(4, 'Mock Organizer Four', 'mock4@example.com', 304, 404, 'www.mock4.com', '9876543213'),
(5, 'Mock Organizer Five', 'mock5@example.com', 305, 405, 'www.mock5.com', '9876543214'),
(6, 'Mock Organizer Six', 'mock6@example.com', 306, 406, 'www.mock6.com', '9876543215'),
(7, 'Mock Organizer Seven', 'mock7@example.com', 307, 407, 'www.mock7.com', '9876543216'),
(8, 'Mock Organizer Eight', 'mock8@example.com', 308, 408, 'www.mock8.com', '9876543217'),
(9, 'Mock Organizer Nine', 'mock9@example.com', 309, 409, 'www.mock9.com', '9876543218'),
(10, 'Mock Organizer Ten', 'mock10@example.com', 310, 410, 'www.mock10.com', '9876543219'),
(11, 'Mock Organizer Eleven', 'mock11@example.com', 311, 411, 'www.mock11.com', '9876543220'),
(12, 'Mock Organizer Twelve', 'mock12@example.com', 312, 412, 'www.mock12.com', '9876543221'),
(13, 'Mock Organizer Thirteen', 'mock13@example.com', 313, 413, 'www.mock13.com', '9876543222'),
(14, 'Mock Organizer Fourteen', 'mock14@example.com', 314, 414, 'www.mock14.com', '9876543223'),
(15, 'Mock Organizer Fifteen', 'mock15@example.com', 315, 415, 'www.mock15.com', '9876543224'),
(16, 'Mock Organizer Sixteen', 'mock16@example.com', 316, 416, 'www.mock16.com', '9876543225'),
(17, 'Mock Organizer Seventeen', 'mock17@example.com', 317, 417, 'www.mock17.com', '9876543226'),
(18, 'Mock Organizer Eighteen', 'mock18@example.com', 318, 418, 'www.mock18.com', '9876543227'),
(19, 'Mock Organizer Nineteen', 'mock19@example.com', 319, 419, 'www.mock19.com', '9876543228'),
(20, 'Mock Organizer Twenty', 'mock20@example.com', 320, 420, 'www.mock20.com', '9876543229'),
(21, 'Mock Organizer Twenty-One', 'mock21@example.com', 321, 421, 'www.mock21.com', '9876543230'),
(22, 'Mock Organizer Twenty-Two', 'mock22@example.com', 322, 422, 'www.mock22.com', '9876543231'),
(23, 'Mock Organizer Twenty-Three', 'mock23@example.com', 323, 423, 'www.mock23.com', '9876543232'),
(24, 'Mock Organizer Twenty-Four', 'mock24@example.com', 324, 424, 'www.mock24.com', '9876543233'),
(25, 'Mock Organizer Twenty-Five', 'mock25@example.com', 325, 425, 'www.mock25.com', '9876543234');

INSERT INTO Ref_Event_Status (Event_Status_Code, Event_Status_Description) VALUES
(1, 'Planned'),
(2, 'In Progress'),
(3, 'Finished'),
(4, 'Called Off'),
(5, 'Delayed');