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


INSERT INTO Ref_Event_Types (Event_Type_Code, Event_Type_Description) VALUES
(1, 'Virtual Meetup'),
(2, 'In-person Workshop'),
(3, 'Executive Seminar'),
(4, 'Online Webinar'),
(5, 'Networking Session'),
(6, 'Exhibition'),
(7, 'Outdoor Adventure'),
(8, 'New Product Showcase'),
(9, 'Interactive Panel'),
(10, 'Career Expo'),
(11, 'Programming Contest'),
(12, 'Leadership Forum'),
(13, 'Community Gathering'),
(14, 'Charity Drive'),
(15, 'Cultural Showcase'),
(16, 'Book Signing'),
(17, 'Athletic Meet'),
(18, 'Tech Expo'),
(19, 'Short Film Premiere'),
(20, 'Music and Arts Festival'),
(21, 'Band Performance'),
(22, 'Dance Competition'),
(23, 'Stage Play'),
(24, 'Knowledge Quiz'),
(25, 'Oratory Challenge');

INSERT INTO Venues (Venue_ID, Venue_Name, Other_Details) VALUES
(1, 'Mock Venue A', 'City Center, capacity 600'),
(2, 'Mock Venue B', 'Outskirts, capacity 400'),
(3, 'Mock Venue C', 'Suburban, capacity 800'),
(4, 'Mock Venue D', 'Scenic Lakeside, capacity 450'),
(5, 'Mock Venue E', 'High-end facility, capacity 250'),
(6, 'Mock Venue F', 'Modern tech setup, capacity 700'),
(7, 'Mock Venue G', 'Open ground, ideal for casual events'),
(8, 'Mock Venue H', 'Large conference space, capacity 1200'),
(9, 'Mock Venue I', 'Workshop-friendly venue, capacity 350'),
(10, 'Mock Venue J', 'Rooftop with city view, capacity 150'),
(11, 'Mock Venue K', 'Garden setting, capacity 200'),
(12, 'Mock Venue L', 'Historic site, capacity 300'),
(13, 'Mock Venue M', 'Amphitheater, seating for 800'),
(14, 'Mock Venue N', 'Cozy studio, capacity 60'),
(15, 'Mock Venue O', 'Stadium, capacity 5500'),
(16, 'Mock Venue P', 'Academic hall, capacity 1300'),
(17, 'Mock Venue Q', 'Hotel event hall, capacity 500'),
(18, 'Mock Venue R', 'Convention hub, capacity 2200'),
(19, 'Mock Venue S', 'Converted warehouse, industrial vibe'),
(20, 'Mock Venue T', 'Art gallery, capacity 350'),
(21, 'Mock Venue U', 'Aquarium hall, underwater ambiance'),
(22, 'Mock Venue V', 'Zoo lawn, outdoor setup'),
(23, 'Mock Venue W', 'Airport hangar, versatile space'),
(24, 'Mock Venue X', 'Library hall, capacity 120'),
(25, 'Mock Venue Y', 'Casino lounge, capacity 550');


INSERT INTO Events (Event_ID, Event_Status_Code, Event_Type_Code, Organizer_ID, Venue_ID, Event_Name, Event_Start_Date, Event_End_Date, Number_of_Participants, Event_Duration, Potential_Cost) VALUES
(1, 1, 1, 1, 1, 'Virtual Meetup 2024', '2024-01-20', '2024-01-20', 400, 1, 20000.00),
(2, 2, 2, 2, 2, 'Interactive Workshop', '2024-02-15', '2024-02-16', 60, 2, 6000.00),
(3, 3, 3, 3, 3, 'Executive Marketing Seminar', '2024-03-10', '2024-03-10', 120, 1, 7000.00),
(4, 4, 4, 4, 4, 'Webinar on AI', '2024-04-25', '2024-04-25', 250, 1, 3500.00),
(5, 5, 5, 5, 5, 'Business Networking Event', '2024-05-05', '2024-05-05', 180, 1, 9000.00),
(6, 1, 6, 6, 6, 'Annual Exhibition', '2024-06-20', '2024-06-22', 1200, 3, 60000.00),
(7, 2, 7, 7, 7, 'Adventure Team Building', '2024-07-12', '2024-07-14', 40, 3, 3500.00),
(8, 3, 8, 8, 8, 'Product Showcase 2024', '2024-08-18', '2024-08-18', 90, 1, 4500.00),
(9, 4, 9, 9, 9, 'Panel Series Discussion', '2024-09-10', '2024-09-12', 300, 3, 11000.00),
(10, 5, 10, 10, 10, 'Career Expo 2024', '2024-10-15', '2024-10-15', 450, 1, 25000.00),
(11, 1, 11, 11, 11, 'National Hackathon', '2024-10-20', '2024-10-21', 160, 2, 15000.00),
(12, 2, 12, 12, 12, 'Leadership Summit', '2024-11-10', '2024-11-10', 50, 1, 6500.00),
(13, 3, 13, 13, 13, 'Community Social Event', '2024-12-12', '2024-12-12', 600, 1, 2500.00),
(14, 4, 14, 14, 14, 'Charity Gala Night', '2025-01-25', '2025-01-25', 320, 1, 16000.00),
(15, 5, 15, 15, 15, 'Cultural Art Showcase', '2025-02-10', '2025-02-12', 750, 3, 12000.00),
(16, 1, 16, 16, 16, 'Book Launch 2025', '2025-03-15', '2025-03-15', 260, 1, 8500.00),
(17, 2, 17, 17, 17, 'Inter-school Sports Meet', '2025-04-20', '2025-04-22', 1050, 3, 22000.00),
(18, 3, 18, 18, 18, 'Science Fair 2025', '2025-05-15', '2025-05-17', 550, 3, 16000.00),
(19, 4, 19, 19, 19, 'Film Screening 2025', '2025-06-20', '2025-06-20', 220, 1, 4000.00),
(20, 5, 20, 20, 20, 'Music and Arts Festival', '2025-07-10', '2025-07-12', 850, 3, 27000.00),
(21, 1, 21, 21, 21, 'Live Music Night', '2025-08-20', '2025-08-20', 1100, 1, 52000.00),
(22, 2, 22, 22, 22, 'Dance Fest 2025', '2025-09-10', '2025-09-10', 420, 1, 16000.00),
(23, 3, 23, 23, 23, 'Theatrical Play Showcase', '2025-10-15', '2025-10-15', 360, 1, 13000.00),
(24, 4, 24, 24, 24, 'Quiz Bowl Nationals', '2025-11-25', '2025-11-25', 520, 1, 7000.00),
(25, 5, 25, 25, 25, 'University Debate 2025', '2025-12-10', '2025-12-10', 330, 1, 8000.00);
