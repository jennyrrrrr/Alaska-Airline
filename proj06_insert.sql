-- Insert Data into Database --

/* NOTE: data inserted for tblCity, tblAirport, and flight times 
in tblFlight were loaded into a csv and then inserted 
using Import Wizard */ 

USE ALASKAAIRLINES
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

-- insert into tblFlight_type
INSERT into tblFlight_Type(FlightTypeName, FlightTypeDescr) values ('Domestic', 'Flights that are only inside of the US')
GO

-- insert into tblFee_Type
INSERT INTO tblFee_Type (FeeTypeName, FeeTypeDescr)
VALUES ('Baggage fees', 'This fee type deals with any baggage fees.'),
('Reservations and service fees', 'This fee type deals with any reservations and service fees.'),
('Change and cancellation fees', 'This fee type deals with any change and cancellation fees'),
('Inflight fees', 'This fee type deals with any inflight fees.')
GO

-- insert into tblCustomer_Type
INSERT INTO tblCustomer_Type (CustomerTypeName, CustomerTypeDescr)
VALUES ('Basic memebr', 'This is the Basic Member customer type in Alaksa Airlines.'),
('MVP', 'This is the MVP customer type in Alaska Airlines.'),
('MVP Gold', 'This is the MVP Gold customer type in Alaksa Airlines.'),
('MVP Gold 75K', 'This is the MVP Gold 75K customer type in Alaska Airlines.'),
('Club 49', 'This is the Club 49 customer type in Alaska Airlines.')
GO

-- insert into tblPosition
INSERT INTO tblPosition (PositionName, PositionDescr) 
VALUES ('Flight attendant', 'Responsible for ensuring the safety of passengers and providing excellent customer services.'),
('Airline administrative support', 'Responsible for answering phone calls, transcribing executive correspondence, and data entry.'),
('Baggage handler', 'Responsible for loading and unloading passenger baggage, mail, food supplies, or other cargos.'),
('Operations agent', 'Responsible for transmitting information from and to pilots, ground crew, and flight schedulers.'),
('Aircraft fueler', 'Responsible for operating the fueling equipment.'),
('Airframe & powerplant mechanics', 'Responsible for tunning, repairing, replacing, or upgrading aircraft engines.'),
('Avionics technician', 'Responsible for working on the electronics system of aircrraft.'),
('Cabin maintenance mechanic', 'Responsible for keeping the interior and exterior of a plane in like-new condition.'),
('Regional sales manager', 'Responsible for overseeing reservations and sale representatives of a dsitrict.'),
('Airport equipment driver', 'Responsible for operating various airfield vehicles such as food trucks and power carts.'),
('Flight dispatcher', 'Responsible for ensuring the safety of a flight for an aircraft and preparing a flight plan.'),
('Food services worker', 'Responsible for preparing and cooking food for the flights.'),
('Ground station attendant', 'Responsible for assisting passengers in the terminal with general questions.'),
('Equipment mechanic', 'Responsible for troubleshooting, repairing, and upgrading airport vehicles and equipment.'),
('Avidation meterologist', 'Responsible for providing weather information to airline flight dispatchers and pilots.'),
('Passenger service agent', 'Responsible for issuing refunds to passengers, selling tickets, and providing travel information.'),
('Ramp planner', 'Responsible for knowing arrival and departure times for each aircraft for the airline at an airport.'),
('Reservation sales agent', 'Responsible for providing travel information over the phone to customers of the airline.'),
('Sales representative', 'Responsible for making flight ticket sales for the airline.'),
('Crew schedule coordinator', 'Responsible for ensuring adequate aircrew staffing and ground support to keep flights on schedule.'),
('Station agent', 'Responsible for taking care of the overall operations of a given airline at a particular airport.'),
('Ticket agent', 'Responsible for greeting customers when they arrive at the airport.'),
('Flight instructor', 'Responsible for providing recurrent training for the pilots at an airline.'),
('Pilot', 'Responsible for operating an aircraft and ensuring the safety of passengers and crew.')

-- insert into tblCity
INSERT INTO tblCity (StateID, CityName)
SELECT StateID, CityName FROM CityAirport
GO

-- insert into tblAirport
INSERT INTO tblAirport (CityID, AirportLetters)
SELECT CityID, AirportLetters FROM CityAirport
GO


-- insert into tblPassenger
INSERT INTO tblPassenger (PassengerFname, PassengerLname,  PassengerDOB, PassengerPhone, PassengerEmail, PassengerStreetAddr, PassengerCity, PassengerState, PassengerZip)
SELECT TOP 1000 CustomerFname, CustomerLname, DateofBirth, PhoneNum, Email, CustomerAddress, CustomerCity, CustomerState, CustomerZIP FROM dbo.PEEPS_Customer_Raw 
GO

-- insert into tblEmployee
INSERT INTO tblEmployee (EmployeeFname, EmployeeLname,  EmployeeDOB, EmployeeEmail, EmployeePhone, EmployeeAddress, EmployeeCity, EmployeeState, EmployeeZip)
SELECT TOP 1000 CustomerFname, CustomerLname, DateofBirth, Email, PhoneNum, CustomerAddress, CustomerCity, CustomerState, CustomerZIP FROM dbo.PEEPS_Customer_Raw 
GO

-- insert 100 rows into tblAirplane
EXEC uspWRAPPER_newAirplane @Run = 100;


-- insert 100 rows into tblCustomer
EXEC usp_wrapper_NewCustomer @Run = 100; 

-- insert into tblEmployee_Position
EXEC uspWRAPPER_rongtNewEmployeePosition @Run = 20;

-- insert into tblEvent
EXEC uspWRAPPER_newEvent @Run = 20;

-- insert into tblOrder
EXEC uspWrapper_NewOrder @Run = 1000;

-- insert into tblFee
EXEC usp_Wrapper_NewFee @Run = 20;

-- insert into tblFlight
EXEC uspWRAPPER_newFlight @Run = 20;


