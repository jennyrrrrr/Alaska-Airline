--inserts into tblState
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

--Inserts for tblAirplane_Manufacturer
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Airbus', 'A french company that makes airplanes')
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Boeing', 'An American company that makes airplanes')
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Bombarier', 'A Canadian company that makes airplanes')
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Embraer', 'A Brazzlian company that makes airplanes')

--Inserts for tblAirplane_Type
INSERT into tblAirplane_Type(AirplaneTypeName) values ('A320')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('737-9 Max')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('737-900ER(739)')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('737-900(739)')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('737-800(738)')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('737-700(73G)')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('Q400 (DH4)')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('175')

--inserts into tblEvent_type
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('natrual disaster', 'An event that happens when it is not caused by humans')
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('natrual disaster', 'An event that happens when an airplane breaks down')

--insert into tblEvent
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
 'Shipment delays','fueling delays, luggage delay and other things that need to be on the airplane before leaving')

--insert into tblEvent_Type
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('canceled', 'A snow storm, high winds, low visilibity')
INSERT into tblEvent_Type(EventTypeName, EventTypeDescr) values ('delayed', 'The flight has been delayed during unfortunate circumstances')

--inserts into airplane
INSERT into tblAirplane(AirplaneTypeID, ManufacturerID, DateMade, TotalFlightHrs) 
values ((select AirplaneTypeID from tblAirplane_Type where AirplaneTypeName = 'A320'),
 (select ManufacturerID from tblAirplane_Manufacturer where ManufacturerName = 'Airbus'),'03/02/2017',28000)
 INSERT into tblAirplane(AirplaneTypeID, ManufacturerID, DateMade, TotalFlightHrs) 
values ((select AirplaneTypeID from tblAirplane_Type where AirplaneTypeName = '737-9 Max'),
 (select ManufacturerID from tblAirplane_Manufacturer where ManufacturerName = 'Boeing'),'08/12/2020',10000)
 INSERT into tblAirplane(AirplaneTypeID, ManufacturerID, DateMade, TotalFlightHrs) 
values ((select AirplaneTypeID from tblAirplane_Type where AirplaneTypeName = '737-900ER(739)'),
 (select ManufacturerID from tblAirplane_Manufacturer where ManufacturerName = 'Boeing'),'03/02/2014',40000)
  INSERT into tblAirplane(AirplaneTypeID, ManufacturerID, DateMade, TotalFlightHrs) 
values ((select AirplaneTypeID from tblAirplane_Type where AirplaneTypeName = '737-900(739)'),
 (select ManufacturerID from tblAirplane_Manufacturer where ManufacturerName = 'Boeing'),'07/21/2015',39000)
 INSERT into tblAirplane(AirplaneTypeID, ManufacturerID, DateMade, TotalFlightHrs) 
values ((select AirplaneTypeID from tblAirplane_Type where AirplaneTypeName = '737-800(738)'),
 (select ManufacturerID from tblAirplane_Manufacturer where ManufacturerName = 'Boeing'),'09/12/2015',50000)
 INSERT into tblAirplane(AirplaneTypeID, ManufacturerID, DateMade, TotalFlightHrs) 
values ((select AirplaneTypeID from tblAirplane_Type where AirplaneTypeName = '737-700(73G)'),
 (select ManufacturerID from tblAirplane_Manufacturer where ManufacturerName = 'Boeing'),'02/04/2014',57000)
 INSERT into tblAirplane(AirplaneTypeID, ManufacturerID, DateMade, TotalFlightHrs) 
values ((select AirplaneTypeID from tblAirplane_Type where AirplaneTypeName = 'Q400 (DH4)'),
 (select ManufacturerID from tblAirplane_Manufacturer where ManufacturerName = 'Bombarier'),'06/21/2017',10000)
 INSERT into tblAirplane(AirplaneTypeID, ManufacturerID, DateMade, TotalFlightHrs) 
values ((select AirplaneTypeID from tblAirplane_Type where AirplaneTypeName = '175'),
 (select ManufacturerID from tblAirplane_Manufacturer where ManufacturerName = 'Embraer'),'05/15/2018',8000)

--insert for manufactures
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Airbus', 'A french company that makes airplanes')
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Boeing', 'An American company that makes airplanes')
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Bombarier', 'A Canadian company that makes airplanes')
INSERT into tblAirplane_Manufacturer(ManufacturerName, ManufacturerDescr) values ('Embraer', 'A Brazzlian company that makes airplanes')

--Inserts for tblAirplane_Type
INSERT into tblAirplane_Type(AirplaneTypeName) values ('A320')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('737-9 Max')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('737-900ER(739)')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('737-900(739)')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('737-800(738)')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('737-700(73G)')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('Q400 (DH4)')
INSERT into tblAirplane_Type(AirplaneTypeName) values ('175')

/*
--inserts into tblAirport
INSERT INTO tblAirport(CityID, AirportLetters)
SELECT CityID, Airportletters FROM CityAirport

--inserts into tblCity
INSERT INTO tblCity(StateID, CityName)
SELECT StateID, CityName FROM CityAirport
*/
--insert into Flight_type
INSERT into tblFlight_Type(FlightTypeName, FlightTypeDescr) values ('Domestic', 'Flights that are only inside of the US')
GO

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