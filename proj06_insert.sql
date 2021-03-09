-- Insert Data into Database --
USE ALASKA_AIRLINES
GO

-- Inserts for tblState -- 
INSERT into tblState(StateLetters, StateName) values ('AL', 'Alabama'),
('AK', 'Alaska'),
('AL', 'Alabama'),
('AZ', 'Arizona'),
('AR', 'Arkansas'),
('CA', 'California'),
('CO', 'Colorado'),
('CT', 'Connecticut'),
('DE', 'Delaware'),
('DC', 'District of Columbia'),
('FL', 'Florida'),
('GA', 'Georgia'),
('HI', 'Hawaii'),
('ID', 'Idaho'),
('IL', 'Illinois'),
('IN', 'Indiana'),
('IA', 'Iowa'),
('KS', 'Kansas'),
('KY', 'Kentucky'),
('LA', 'Louisiana'),
('ME', 'Maine'),
('MD', 'Maryland'),
('MA', 'Massachusetts'),
('MI', 'Michigan'),
('MN', 'Minnesota'),
('MS', 'Mississippi'),
('MO', 'Missouri'),
('MT', 'Montana'),
('NE', 'Nebraska'),
('NV', 'Nevada'),
('NH', 'New Hampshire'),
('NJ', 'New Jersey'),
('NM', 'New Mexico'),
('NY', 'New York'),
('NC', 'North Carolina'),
('ND', 'North Dakota'),
('OH', 'Ohio'),
('OK', 'Oklahoma'),
('OR', 'Oregon'),
('PA', 'Pennsylvania'),
('PR', 'Puerto Rico'),
('RI', 'Rhode Island'),
('SC', 'South Carolina'),
('SD', 'South Dakota'),
('TN', 'Tennessee'),
('TX', 'Texas'),
('UT', 'Utah'),
('VT', 'Vermont'),
('VA', 'Virginia'),
('WA', 'Washington'),
('WV', 'West Virginia'),
('WI', 'Wisconsin'),
('WY', 'Wyoming');
GO

--Inserts for tblAirplane_Manufacturer
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Airbus', 'A French company that makes airplanes')
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Boeing', 'An American company that makes airplanes')
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Bombarier', 'A Canadian company that makes airplanes')
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Embraer', 'A Brazilian company that makes airplanes')
GO

--Inserts for tblAirplane_Type
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('A320', (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Airbus'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('737-9 Max', (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Boeing'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('737-900ER(739)', (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Boeing'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('737-900(739)',  (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Boeing'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('737-800(738)',  (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Boeing'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('737-700(73G)',  (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Boeing'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('Q400 (DH4)',  (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Bombarier'))
INSERT into tblAirplane_Type(AirplaneTypeName, ManufacturerID) values ('175',  (SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = 'Embraer'))
GO

--inserts into tblEvent_type
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('Wind Storm', 'Wind strong enough to cause more than normal turbulance')
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('Passenger Medical Problem', 'Passenger on flight has medical issue that needed immediate attention')
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('Emergency Landing', 'Had to land early due to an emergency')
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('Extreme Lightning', 'Lightning close to plane that caused some sort of disruptance')
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('Canceled Flight', 'Issue that caused flight to be canceled')
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('Delayed Flight', 'Issue that caused flight to be delayed')
GO

/* use synthetic transaction
INSERT into tblEvent(EventTypeID, EventName, EventDescr) 
values ((select EventTypeID from tblEvent_Type where EventTypeName = 'canceled'),
 'Natural disasters','fueling delays, luggage delay and other things that need to be on the airplane before leaving')
INSERT into tblEvent(EventTypeID, EventName, EventDescr) 
values ((select EventTypeID from tblEvent_Type where EventTypeName = 'canceled'),
 'Mechanical issues', 'problems with the airplane')
INSERT into tblEvent(EventTypeID, EventName, EventDescr) 
values ((select EventTypeID from tblEvent_Type where EventTypeName = 'delayed'),
 'traffic control','When there is a busy runway or busy area around the airport')
INSERT into tblEvent(EventTypeID, EventName, EventDescr) 
values ((select EventTypeID from tblEvent_Type where EventTypeName = 'delayed'),
 'Shipment delays','fueling delays, luggage delay and other things that need to be on the airplane before leaving') */ 


-- insert into tblFlight_type
INSERT into tblFlight_Type(FlightTypeName, FlightTypeDescr) values ('Domestic', 'Flights that are only inside of the US')
GO

-- insert into tblCustomer
INSERT INTO INFO430_Proj_06.dbo.tblCustomer (CustomerFname, CustomerLname, CustomerPhone, CustomerEmail, CustomerStreetAddr, CustomerCity, CustomerState, CustomerZip, CustomerDOB)
SELECT TOP 100000 CustomerFname, CustomerLname, PhoneNum, Email, CustomerAddress, CustomerCity, CustomerState, CustomerZIP, DateofBirth FROM PEEPS.dbo.tblCUSTOMER

-- insert 100 rows into tblAirplane
CREATE PROCEDURE uspWRAPPER_newAirplane
@Run INT 
AS
DECLARE @ATypeCount INT = (SELECT COUNT(*) FROM tblAirplane_Type)

DECLARE @ATName VARCHAR(50), @MName VARCHAR(50)
DECLARE @Date_Made DATE, @T_Hrs FLOAT

DECLARE @PK INT
DECLARE @Rand INT

WHILE @Run > 0 
BEGIN

SET @PK = (SELECT RAND() * @ATypeCount + 1)
SET @ATName = (SELECT AirplaneTypeName FROM tblAirplane_Type WHERE AirplaneTypeID = @PK)

SET @Date_Made = (SELECT GetDate() - (SELECT Rand() * 1000))

SET @T_Hrs = (SELECT Rand() * 100000)

EXEC [newAirplane]
@AType_Name = @ATName, 
@Date = @Date_Made, 
@Hrs = @T_Hrs

SET @Run = @Run - 1
END

EXEC uspWRAPPER_newAirplane @Run = 100;

SELECT * FROM tblAirplane