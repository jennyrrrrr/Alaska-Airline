CREATE DATABASE ALASKA_AIRLINES
GO

USE ALASKA_AIRLINES
GO

--Create Tables--
CREATE TABLE tblBooking
(BookingID INTEGER IDENTITY(1,1) PRIMARY KEY,
PassengerID INT NOT NULL,
FlightID INT NOT NULL,
FeeID INT NOT NULL,
OrderID INT NOT NULL, 
BookingAmount FLOAT NOT NULL)
GO
 
CREATE TABLE tblFlight
(FlightID INTEGER IDENTITY(1,1) PRIMARY KEY,
AirplaneID INT NOT NULL,
FlightTypeID INT NOT NULL,
DepartureAirportID INT NOT NULL,
ArrivalAirportID INT NOT NULL,
ArrivalTime TIME NOT NULL,
DepartureTime TIME NOT NULL,
FlightHrs FLOAT NOT NULL)
GO
 
CREATE TABLE tblBooking_Fee
(BookingFeeID INTEGER IDENTITY(1,1) PRIMARY KEY,
BookingID INT NOT NULL,
FeeID INT NOT NULL)
GO
 
CREATE TABLE tblFlight_Type
(FlightTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
FlightTypeName VARCHAR(20) NOT NULL,
FlightTypeDescr VARCHAR(100) NOT NULL)
GO
 
CREATE TABLE tblFlight_Event
(FlightEventID INTEGER IDENTITY(1,1) PRIMARY KEY,
EventID INT NOT NULL,
FlightID INT NOT NULL)
GO

create TABLE tblAirport
(AirportID INTEGER IDENTITY(1,1) PRIMARY KEY,
CityID INT NOT NULL,
AirportLetters VARCHAR(5) NOT NULL)
GO

CREATE TABLE tblAirplane_Type
(AirplaneTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
AirplaneTypeName VARCHAR(50) NOT NULL,
ManufacturerID INT NOT NULL)
GO
 
CREATE TABLE tblAirplane_Manufacturer
(ManufacturerID INTEGER IDENTITY(1,1) PRIMARY KEY,
ManufacturerName VARCHAR(50) NOT NULL, 
ManufacturerDescr VARCHAR(100) NOT NULL)
GO

CREATE TABLE tblAirplane
(AirplaneID INTEGER IDENTITY(1,1) PRIMARY KEY,
AirplaneTypeID INT NOT NULL,
DateMade DATE NOT NULL, 
TotalFlightHrs FLOAT NOT NULL)
GO
 
CREATE TABLE tblEvent_Type
(EventTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
EventTypeName VARCHAR(50) NOT NULL, 
EventTypeDescr VARCHAR(100) NOT NULL)
GO
 
CREATE TABLE tblEvent
(EventID INTEGER IDENTITY(1,1) PRIMARY KEY,
EventTypeID INT NOT NULL,  
EventName VARCHAR(50) NOT NULL, 
EventDescr VARCHAR(100) NOT NULL)
GO

CREATE TABLE tblEmployee
(EmployeeID INTEGER IDENTITY(1,1) PRIMARY KEY,
EmployeeFname VARCHAR(50) NOT NULL,
EmployeeLname VARCHAR(50) NOT NULL,
EmployeeDOB DATE NOT NULL,
EmployeeEmail VARCHAR(50) NOT NULL,
EmployeePhone VARCHAR(15) NOT NULL,
EmployeeAddress VARCHAR(50) NOT NULL,
EmployeeCity VARCHAR(50) NOT NULL,
EmployeeState VARCHAR(50) NOT NULL,
EmployeeZip VARCHAR(50) NOT NULL)
GO

CREATE TABLE tblEmployee_Flight
(EmployeeFlightID INTEGER IDENTITY(1,1) PRIMARY KEY,
FlightID INT NOT NULL,
EmployeeID INT NOT NULL)
GO

CREATE TABLE tblEmployee_Position
(EmployeePositionID INTEGER IDENTITY(1,1) PRIMARY KEY,
EmployeeID INT NOT NULL,
PositionID INT NOT NULL)
GO

CREATE TABLE tblPosition
(PositionID INTEGER IDENTITY(1,1) PRIMARY KEY,
PositionName VARCHAR(50) NOT NULL,
PositionDescr VARCHAR(100) NOT NULL)
GO

CREATE TABLE tblCity
(CityID INTEGER IDENTITY(1,1) PRIMARY KEY,
StateID INT NOT NULL,
CityName VARCHAR(50) NOT NULL)
GO

CREATE TABLE tblState
(StateID INTEGER IDENTITY(1,1) PRIMARY KEY,
StateLetters VARCHAR(2) NOT NULL, 
StateName VARCHAR(50) NOT NULL)
GO

CREATE TABLE tblCustomer_Type
(CustomerTypeID INT IDENTITY(1,1) PRIMARY KEY,
CustomerTypeName VARCHAR(100) NOT NULL,
CustomerTypeDescr VARCHAR(100) NOT NULL)
GO 

CREATE TABLE tblCustomer
(CustomerID INT IDENTITY(1,1) PRIMARY KEY,
CustomerTypeID INT NOT NULL,
CustomerFname VARCHAR(50) NOT NULL,
CustomerLname VARCHAR(50) NOT NULL,
CustomerPhone VARCHAR(50) NOT NULL,
CustomerDOB DATE NOT NUll,
CustomerEmail VARCHAR(50) NOT NULL,
CustomerStreetAddr VARCHAR(50) NOT NULL,
CustomerCity VARCHAR(50) NOT NULL,
CustomerState VARCHAR(50) NOT NULL,
CustomerZip VARCHAR(50))   
GO
 
CREATE TABLE tblOrder
(OrderID INT IDENTITY(1,1) PRIMARY KEY,
CustomerID INT NOT NULL,
OrderDate DATE NOT NULL)
GO 
 
CREATE TABLE tblFee_Type
(FeeTypeID INT IDENTITY(1,1) PRIMARY KEY,
FeeTypeName VARCHAR(50) NOT NULL,
FeeTypeDescr VARCHAR(100) NOT NULL) 
GO
 
CREATE TABLE tblFee
(FeeID INT IDENTITY(1,1) PRIMARY KEY,
FeeName VARCHAR(50) NOT NULL,
FeeTypeID INT NOT NULL,
FeeAmount MONEY NOT NULL) 
GO
 
CREATE TABLE tblPassenger
(PassengerID INT IDENTITY(1,1) PRIMARY KEY,
PassengerFname VARCHAR(50),
PassengerLname VARCHAR(50),
PassengerPhone VARCHAR(50),
PassengerEmail VARCHAR(50),
PassengerStreetAddr VARCHAR(50),
PassengerCity VARCHAR(50),
PassengerState VARCHAR(50),
PassengerZip VARCHAR(50))
GO

--Add Foreign Keys--
ALTER TABLE tblBooking
Add CONSTRAINT FK_PassengerID
 FOREIGN KEY (PassengerID) REFERENCES tblPassenger(PassengerID);
GO
 
ALTER TABLE tblBooking
Add CONSTRAINT FK_FlightID
 FOREIGN KEY (FlightID) REFERENCES tblFlight(FlightID);
GO
 
ALTER TABLE tblBooking
Add CONSTRAINT FK_OrderID
 FOREIGN KEY (OrderID) REFERENCES tblOrder(OrderID);
GO

ALTER TABLE tblFlight
Add CONSTRAINT FK_AirplaneID
 FOREIGN KEY (AirplaneID) REFERENCES tblAirplane(AirplaneID);
GO
 
ALTER TABLE tblFlight
Add CONSTRAINT FK_FlightTypeID
 FOREIGN KEY (FlightTypeID) REFERENCES tblFlight_Type(FlightTypeID);
GO

ALTER TABLE tblFlight
Add CONSTRAINT FK_DepartureAirportID
 FOREIGN KEY (DepartureAirportID) REFERENCES tblAirport(AirportID);
GO

ALTER TABLE tblFlight
Add CONSTRAINT FK_ArrivalAirportID
 FOREIGN KEY (ArrivalAirportID) REFERENCES tblAirport(AirportID);
GO
 
ALTER TABLE tblBooking_Fee
Add CONSTRAINT FK_BookingID
 FOREIGN KEY (BookingID) REFERENCES tblBooking(BookingID);
GO
 
ALTER TABLE tblBooking_Fee
Add CONSTRAINT FK_FeeID
 FOREIGN KEY (FeeID) REFERENCES tblFee(FeeID);
GO

ALTER TABLE tblFlight_Event
Add CONSTRAINT FK_EventID
 FOREIGN KEY (EventID) REFERENCES tblEvent(EventID);
GO
 
ALTER TABLE tblFlight_Event
Add CONSTRAINT FK_FlightID2
 FOREIGN KEY (FlightID) REFERENCES tblFlight(FlightID);
GO

ALTER TABLE tblAirport
Add CONSTRAINT FK_CityID
 FOREIGN KEY (CityID) REFERENCES tblCity(CityID);
GO
 
ALTER TABLE tblAirplane_Type
ADD CONSTRAINT FK_ManufacturerID
 FOREIGN KEY (ManufacturerID) REFERENCES tblAirplane_Manufacturer(ManufacturerID);
GO
 
ALTER TABLE tblAirplane
ADD CONSTRAINT FK_AirplaneTypeID
 FOREIGN KEY (AirplaneTypeID) REFERENCES tblAirplane_Type(AirplaneTypeID);
GO

ALTER TABLE tblEvent
ADD CONSTRAINT FK_EventTypeID
 FOREIGN KEY (EventTypeID) REFERENCES tblEvent_Type(EventTypeID);
GO

ALTER TABLE tblEmployee_Flight
ADD CONSTRAINT FK_EmployeeID
 FOREIGN KEY (EmployeeID) REFERENCES tblEmployee(EmployeeID)
GO

ALTER TABLE tblEmployee_Flight
ADD CONSTRAINT FK_FlightID3
 FOREIGN KEY (FlightID) REFERENCES tblFlight(FlightID)
GO

ALTER TABLE tblEmployee_Position
ADD CONSTRAINT FK_EmployeeID2
 FOREIGN KEY (EmployeeID) REFERENCES tblEmployee(EmployeeID)
GO

ALTER TABLE tblEmployee_Position
ADD CONSTRAINT FK_PositionID
 FOREIGN KEY (PositionID) REFERENCES tblPosition(PositionID)
GO

ALTER TABLE tblCity
Add CONSTRAINT FK_StateID
 FOREIGN KEY (StateID) REFERENCES tblstate(StateID);
GO

ALTER TABLE tblCustomer 
ADD CONSTRAINT FK_CustomerTypeID
    FOREIGN KEY (CustomerTypeID) REFERENCES tblCustomer_Type(CustomerTypeID);
GO

ALTER TABLE tblOrder 
ADD CONSTRAINT FK_CustomerID
    FOREIGN KEY (CustomerID) REFERENCES tblCustomer(CustomerID);
GO

ALTER TABLE tblFee
ADD CONSTRAINT FK_FeeTypeID
    FOREIGN KEY (FeeTypeID) REFERENCES tblFee_Type(FeeTypeID);
GO