USE INFO430_Proj_06
GO

CREATE TABLE tblBooking
(BookingID INTEGER IDENTITY(1,1) PRIMARY KEY,
PassengerID INT NOT NULL,
FlightID INT NOT NULL,
FeeID INT NOT NULL,
OrderID INT NOT NULL,
EventID INT NOT NULL)
GO
 
CREATE TABLE tblFlight
(FlightID INTEGER IDENTITY(1,1) PRIMARY KEY,
AirplaneID INT NOT NULL,
FlightTypeID INT NOT NULL,
DepartureAirportID INT NOT NULL,
ArrivalAirportID INT NOT NULL,
ArrivalTime TIME NOT NULL,
DepartureTime TIME NOT NULL,
FlightHrs INT NOT NULL)
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
 
CREATE TABLE tblAirport
(AirportID INTEGER IDENTITY(1,1) PRIMARY KEY,
CityID INT NOT NULL,
AirportLetters VARCHAR(5) NOT NULL,
AirportName VARCHAR(50) NOT NULL)
GO
 
CREATE TABLE tblAirplane_Type
(AirplaneTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
AirplaneTypeName VARCHAR(50) NOT NULL, 
AirplaneTypeDescr VARCHAR(100) NOT NULL)
GO
 
CREATE TABLE tblAirplane_Manufacturer
(ManufacturerID INTEGER IDENTITY(1,1) PRIMARY KEY,
ManufacturerName VARCHAR(50) NOT NULL, 
ManufacturerDescr VARCHAR(100) NOT NULL)
GO
 
CREATE TABLE tblAirplane
(AirplaneID INTEGER IDENTITY(1,1) PRIMARY KEY,
AirplaneTypeID INT NOT NULL,
ManufacturerID INT NOT NULL,  
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
CustomerTypeID INT FOREIGN KEY(CustomerTypeID) REFERENCES tblCustomer_Type(CustomerTypeID),
CustomerFname VARCHAR(50) NOT NULL,
CustomerLname VARCHAR(50) NOT NULL,
CustomerPhone VARCHAR(50) NOT NULL,
CustomerEmail VARCHAR(50) NOT NULL,
CustomerStreetAddr VARCHAR(50) NOT NULL,
CustomerCity VARCHAR(50) NOT NULL,
CustomerState VARCHAR(50) NOT NULL,
CustomerZip VARCHAR(50))   
GO
 
CREATE TABLE tblOrder
(OrderID INT IDENTITY(1,1) PRIMARY KEY,
CustomerID INT FOREIGN KEY(CustomerID) REFERENCES tblCustomer(CustomerID),
OrderDate DATE NOT NULL)
GO 
 
CREATE TABLE tblFee_Type
(FeeTypeID INT IDENTITY(1,1) PRIMARY KEY,
FeeTypeName VARCHAR(50) NOT NULL,
FeeTypeDescr VARCHAR(100) NOT NULL) 
GO
 
--Might run into issues because of fee amount.
CREATE TABLE tblFee
(FeeID INT IDENTITY(1,1) PRIMARY KEY,
FeeName VARCHAR(50) NOT NULL,
FeeTypeID INT FOREIGN KEY(FeeTypeID) REFERENCES tblFee_Type(FeeTypeID),
FeeAmount NUMERIC NOT NULL,
FeeDescr  VARCHAR(100)) 
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

--FOREIGN KEYS--
ALTER TABLE tblBooking
Add CONSTRAINT FK_PassengerID
 FOREIGN KEY (PassengerID) REFERENCES tblPassenger(PassengerID);
GO
 
ALTER TABLE tblBooking
Add CONSTRAINT FK_FlightID
 FOREIGN KEY (FlightID) REFERENCES tblFlight(FlightID);
GO
 
ALTER TABLE tblBooking
Add CONSTRAINT FK_FeeID
 FOREIGN KEY (FeeID) REFERENCES tblFee(FeeID);
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
 
ALTER TABLE tblBooking_Fee
Add CONSTRAINT FK_BookingID
 FOREIGN KEY (BookingID) REFERENCES tblBooking(BookingID);
GO
 
ALTER TABLE tblBooking_Fee
Add CONSTRAINT FK_FeeID2
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
ADD CONSTRAINT FK_CityID
 FOREIGN KEY (CityID) REFERENCES tblCity(CityID);
GO
 
ALTER TABLE tblAirplane
ADD CONSTRAINT FK_AirplaneTypeID
 FOREIGN KEY (AirplaneTypeID) REFERENCES tblAirplane_Type(AirplaneTypeID);
GO
 
ALTER TABLE tblAirplane
ADD CONSTRAINT FK_ManufacturerID
 FOREIGN KEY (ManufacturerID) REFERENCES tblAirplane_Manufacturer(ManufacturerID);
GO
 
ALTER TABLE tblEvent
ADD CONSTRAINT FK_EventTypeID
 FOREIGN KEY (EventTypeID) REFERENCES tblEvent_Type(EventTypeID);
GO

ALTER TABLE tblEmployee_Position
ADD CONSTRAINT FK_EmployeeID
 FOREIGN KEY (EmployeeID) REFERENCES tblEmployee(EmployeeID)
GO

ALTER TABLE tblCity
ADD CONSTRAINT FK_StateID
 FOREIGN KEY (StateID) REFERENCES tblState(StateID);
GO
 

ALTER TABLE tblBooking
Add CONSTRAINT FK_EventID2
 FOREIGN KEY (EventID) REFERENCES tblEvent(EventID);
GO

ALTER TABLE tblEmployee_Position
ADD CONSTRAINT FK_PositionID
 FOREIGN KEY (PositionID) REFERENCES tblPosition(PositionID)
GO

-- Stored procedures--

-- Allison's code
CREATE PROCEDURE getAirplaneTypeID
@AT_Name VARCHAR(50), 
@AT_ID INT OUTPUT
AS 
SET @AT_ID = 
(SELECT AirplaneTypeID FROM tblAirplane_Type WHERE AirplaneTypeName = @AT_Name)
GO 
 
CREATE PROCEDURE getManufacturerID
@MFG_Name VARCHAR(50), 
@MFG_ID INT OUTPUT
AS 
SET @MFG_ID = 
(SELECT ManufacturerID FROM tblAirplane_Manufacturer WHERE ManufacturerName = @MFG_Name)
GO 
 
CREATE PROCEDURE getEventTypeID
@ET_Name VARCHAR(50), 
@ET_ID INT OUTPUT
AS 
SET @ET_ID = 
(SELECT EventTypeID FROM tblEvent_Type WHERE EventTypeName = @ET_Name)
GO 
 
-- create insert stored procedures 
CREATE PROCEDURE newAirplane
@AType_Name VARCHAR(50), 
@Manu_Name VARCHAR(50), 
@Date DATE, 
@Hrs FLOAT
AS 
DECLARE
@AType_ID INT, @Manu_ID INT
 
EXEC getAirplaneTypeID
@AT_Name = @AType_Name, 
@AT_ID = @AType_ID OUTPUT
 
IF @AType_ID IS NULL 
    BEGIN 
        PRINT '@AType_ID cannot be empty - will fail in transaction'; 
        THROW 51100, '@AType_ID cannot be null',1; 
    END
 
EXEC getManufacturerID
@MFG_Name = @Manu_Name, 
@MFG_ID = @Manu_ID OUTPUT
 
IF @Manu_ID IS NULL 
    BEGIN 
        PRINT '@Manu_ID cannot be empty - will fail in transaction'; 
        THROW 51200, '@Manu_ID cannot be null',1; 
    END
 
BEGIN TRAN T1
    INSERT INTO tblAirplane
    (AirplaneTypeID, ManufacturerID, DateMade, TotalFlightHrs)
    VALUES 
    (@AType_ID, @Manu_ID, @Date, @Hrs)
    IF @@ERROR <> 0
        BEGIN 
            PRINT 'There is an error - rolling back transaction T1'
            ROLLBACK TRAN T1
        END
    ELSE
COMMIT TRAN T1
GO
 
CREATE PROCEDURE newEvent
@EventT_Name VARCHAR(50), 
@Event_Name VARCHAR(50), 
@Event_Descr VARCHAR(100)
AS 
DECLARE
@EventT_ID INT
 
EXEC getEventTypeID
@ET_Name = @EventT_Name, 
@ET_ID = @EventT_ID OUTPUT
 
IF @EventT_ID IS NULL 
    BEGIN 
        PRINT '@EventT_ID cannot be empty - will fail in transaction'; 
        THROW 51300, '@EventT_ID cannot be null',1; 
    END
 
BEGIN TRAN T1
    INSERT INTO tblEvent
    (EventTypeID, EventID, EventDescr)
    VALUES 
    (@EventT_ID, @Event_Name, @Event_Descr)
    IF @@ERROR <> 0
        BEGIN 
            PRINT 'There is an error - rolling back transaction T1'
            ROLLBACK TRAN T1
        END
    ELSE
COMMIT TRAN T1
GO

--Jenny's code

CREATE PROCEDURE getEmployeeID
@EmployeeFnamey VARCHAR(50),
@EmployeeLnamey VARCHAR(50),
@EmployeeEmaily VARCHAR(50),
@EmployeePhoney VARCHAR(15),
@EmployeeAddressy VARCHAR(50),
@EmployeeCityy VARCHAR(50),
@EmployeeStatey VARCHAR(50),
@EmployeeZipy VARCHAR(50),
@EmployeeID INT OUTPUT
AS
SET @EmployeeID = (
   SELECT EmployeeID
   FROM tblEMPLOYEE
   WHERE EmployeeFname = @EmployeeFnamey
       AND EmployeeLname = @EmployeeLnamey
       AND EmployeeEmail = @EmployeeEmaily
       AND EmployeePhone = @EmployeePhoney
       AND EmployeeAddress = @EmployeeAddressy
       AND EmployeeCity = @EmployeeCityy
       AND EmployeeState = @EmployeeStatey
       AND EmployeeZip = @EmployeeZipy)
GO

 
CREATE PROCEDURE getPostionID
@PositionNamey VARCHAR(50),
@PositionDescry VARCHAR(50),
@PositionIDa INT OUTPUT
AS
SET @PositionIDa = (
   SELECT PositionID
   FROM tblPOSITION
   WHERE PositionName = @PositionNamey
       AND PositionDescr = @PositionDescry)
GO
 
CREATE PROCEDURE getStateID
@StateLettersy VARCHAR(2),
@StateNamey VARCHAR(50),
@StateID INT OUTPUT
AS
SET @StateID = (
   SELECT StateID
   FROM tblSTATE
   WHERE StateLetters = @StateLettersy
       AND StateName = @StateNamey)
GO
--still missing the inserts

--Andrew's code
CREATE PROCEDURE getFlight_TypeID
@FlightType_Name VARCHAR(20), 
@FlightType_Descr VARCHAR(100),
@FlightType_ID INT OUTPUT
AS 
SET @FlightType_ID = 
(SELECT FlightTypeID FROM tblFlight_Type WHERE FlightTypeName = @FlightType_Name)
GO 

--Wanyu's code
CREATE PROCEDURE uspGetCustomerTypeID
@Customer_Type_Name VARCHAR(100),
@Customer_Type_ID INT OUTPUT
AS
SET @Customer_Type_ID = (SELECT CustomerTypeID FROM tblCustomer_Type WHERE CustomerTypeName = @Customer_Type_Name)
GO



-- inserting
BULK INSERT tblEMPLOYEE from '/Users/andrewgabra/desktop/MOCK_DATA.csv' WITH
(
	FIELDTERMINATOR = ',',
	FIRSTROW = 2
)
GO