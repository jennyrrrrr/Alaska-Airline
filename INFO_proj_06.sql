USE INFO430_Proj_06
GO

select createdate from tblCUSTOMER
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

create TABLE tblAirport
(AirportID INTEGER IDENTITY(1,1) PRIMARY KEY,
CityID INT NOT NULL,
AirportLetters VARCHAR(5) NOT NULL)
GO

CREATE TABLE tblAirplane_Type
(AirplaneTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
AirplaneTypeName VARCHAR(50) NOT NULL)
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
CustomerDOB DATE NOT NUll,
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
 
CREATE TABLE tblFee
(FeeID INT IDENTITY(1,1) PRIMARY KEY,
FeeName VARCHAR(50) NOT NULL,
FeeTypeID INT FOREIGN KEY(FeeTypeID) REFERENCES tblFee_Type(FeeTypeID),
FeeAmount MONEY NOT NULL,
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
Add CONSTRAINT FK_CityID
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

ALTER TABLE tblCity
Add CONSTRAINT FK_StateIID
 FOREIGN KEY (StateID) REFERENCES tblstate(StateID);
GO

-- Stored procedures--
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

CREATE PROCEDURE getEmployeeID
@EmployeeFnamey VARCHAR(50),
@EmployeeLnamey VARCHAR(50),
@EmployeeEmaily VARCHAR(50),
@EmployeePhoney VARCHAR(15),
@EmployeeAddressy VARCHAR(50),
@EmployeeCityy VARCHAR(50),
@EmployeeStatey VARCHAR(50),
@EmployeeZipy VARCHAR(50),
@EmployeeIDy INT OUTPUT
AS
SET @EmployeeIDy = (
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
@PositionIDy INT OUTPUT
AS
SET @PositionIDy = 
(SELECT PositionID FROM tblPOSITION WHERE PositionName = @PositionNamey AND PositionDescr = @PositionDescry)
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


CREATE PROCEDURE uspGetCustomerID
@Customer_Fname VARCHAR(50),
@Customer_Lname VARCHAR(50),
@Customer_ID INT OUTPUT
AS
SET @Customer_ID = 
(SELECT CustomerID FROM tblCustomer WHERE CustomerFname = @Customer_Fname AND CustomerLname = @Customer_Fname)
GO

CREATE PROCEDURE uspGetFeeTypeID
@Fee_Type_Name VARCHAR(50),
@Fee_Type_ID INT OUTPUT
AS
SET @Fee_Type_ID = (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = @Fee_Type_Name)
GO

CREATE PROCEDURE uspGetPassengerID
@Passenger_Fname VARCHAR(50),
@Passenger_Lname VARCHAR(50),
@Passenger_Birth DATE,
@Passenger_ID INT OUTPUT
AS
SET @Passenger_ID = 
(SELECT PassengerID FROM tblPassenger WHERE PassengerFname = @Passenger_Fname AND PassengerLname = @Passenger_Lname)
GO


CREATE PROCEDURE getFlight_TypeID
@FlightType_Name VARCHAR(20), 
@FlightType_Descr VARCHAR(100),
@FlightType_ID INT OUTPUT
AS 
SET @FlightType_ID = 
(SELECT FlightTypeID FROM tblFlight_Type WHERE FlightTypeName = @FlightType_Name)
GO 

--OrderID, BookingID, AirplaneID, DepartureAirportId, ArrivalAirpportID

--needs to be reviewed 
CREATE PROCEDURE getFlightID
@FlightHrs INT,
@FlightID INT OUTPUT
AS 
SET @FlightID = 
(SELECT FlightID FROM tblFlight WHERE FlightHrs = @FlightHrs)
GO 

CREATE PROCEDURE getFeeID
@FeeName VARCHAR(20), 
@FeeDescr VARCHAR(100),
@FeeID INT OUTPUT
AS 
SET @FeeID = 
(SELECT FeeID FROM tblFee WHERE FeeName = @FeeName AND FeeDescr = @FeeDescr)
GO 

CREATE PROCEDURE getCityID
@CityName VARCHAR(20), 
@CityID INT OUTPUT
AS 
SET @CityID = 
(SELECT CityID FROM tblCity WHERE CityName = @CityName)
GO 

CREATE PROCEDURE getEventID
@EventName VARCHAR(20), 
@EventDescr VARCHAR(100),
@EventID INT OUTPUT
AS 
SET @EventID = 
(SELECT EventID FROM tblEvent WHERE EventName = @EventName AND EventDescr = @EventDescr)
GO 



-------
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

-------

-- Insert Stored Procedures 
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

CREATE PROCEDURE newEmployeePosition
    @EF VARCHAR(50),
    @EL VARCHAR(50),
    @EE VARCHAR(50),
    @EP VARCHAR(15),
    @EA VARCHAR(50),
    @EC VARCHAR(50),
    @ES VARCHAR(50),
    @EZ VARCHAR(50),
    @PN VARCHAR(50),
    @PD VARCHAR(100)
    AS
    DECLARE @E_ID INT, @P_ID INT

    EXEC getEmployeeID
    @EmployeeFnamey = @EF,
    @EmployeeLnamey = @EL,
    @EmployeeEmaily = @EE,
    @EmployeePhoney = @EP,
    @EmployeeAddressy = @EA,
    @EmployeeCityy = @EC,
    @EmployeeStatey = @ES,
    @EmployeeZipy = @EZ,
    @EmployeeIDy = @E_ID OUTPUT
    IF @E_ID IS NULL 
        BEGIN 
            PRINT '@E_ID IS NULL'
            RAISERROR ('@E_ID CAN NOT BE NULL', 11, 1)
            RETURN
        END

    EXEC getPostionID
    @PositionNamey = @PN,
    @PositionDescry = @PD,
    @PositionIDy = @P_ID OUTPUT
    IF @P_ID IS NULL 
        BEGIN 
            PRINT '@P_ID IS NULL'
            RAISERROR ('@P_ID CAN NOT BE NULL', 11, 1)
            RETURN
        END

    BEGIN TRAN G1
        INSERT INTO tblEmployee_Position(EmployeeID, PositionID)
        VALUES (@E_ID, @P_ID)
        IF @@ERROR <> 0
            BEGIN 
                PRINT Error_Message()
                ROLLBACK TRAN T1
            END 
        ELSE 
            COMMIT TRAN T1
GO

CREATE PROCEDURE newCity
    @SL VARCHAR(50), 
    @SN VARCHAR(50), 
    @CN VARCHAR(100)
    AS 
    DECLARE
    @S_ID INT
    
    EXEC getStateID
    @StateLettersy = @SL, 
    @StateNamey = @SN,
    @StateID = @S_ID OUTPUT
    
    IF @S_ID IS NULL 
        BEGIN 
            PRINT '@EventT_ID cannot be empty - will fail in transaction'; 
            THROW 51300, '@EventT_ID cannot be null',1; 
        END
    
    BEGIN TRAN T1
        INSERT INTO tblCity
        (StateID, CityName)
        VALUES 
        (@S_ID, @CN)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error - rolling back transaction T1'
                ROLLBACK TRAN T1
            END
        ELSE
    COMMIT TRAN T1
GO

CREATE PROCEDURE uspGetOrderID
@CustomerFname VARCHAR(50),
@CustomerLname VARCHAR(50),
@OrderDate DATE
AS
DECLARE @CustomerID INT 
 
EXEC uspGetOrderID
@Customer_Fname = @CustomerFname,
@Customer_Lname = @CustomerFname,
@Customer_ID = @CustomerID OUTPUT
-- Error handle @CustomerID in case if it's NULL/empty
IF @CustomerID IS NULL
BEGIN 
    PRINT '@CustomerID is empty and this will cause the transaction to be failed';
    THROW 51000, '@CustomerID cannot be NULL', 1;
    END
GO   

CREATE PROCEDURE uspGetFeeID 
@FeeTypeName VARCHAR(50),
@FeeName VARCHAR(50),
@FeeAmount NUMERIC(8,5),
@FeeDescr VARCHAR(100)
AS 
DECLARE @FeeTypeID INT
 
EXEC uspGetFeeID
@Fee_Type_Name = @FeeTypeName,
@Fee_Type_ID = @FeeTypeID OUTPUT
-- Error handle if in case if it's NULL/ empty
IF @FeeTypeID IS NULL
BEGIN 
    PRINT '@FeeTypeID is empty and this will cause the transaction to be failed';
    THROW 51000, '@FeeTypeID cannot be NULL', 1;
    END
GO

CREATE PROCEDURE InsertNewCustomer 
@Customer_Fname VARCHAR(50),
@Customer_Lname VARCHAR(50),
@Customer_Phone VARCHAR(50),
@Customer_Email VARCHAR(50),
@Customer_Street_Addr VARCHAR(50),
@Customer_City VARCHAR(50),
@Customer_State VARCHAR(50),
@Customer_Zip VARCHAR(50),
@CustomerTypeName VARCHAR(50)
AS
DECLARE @CustomerTypeID INT
 
EXEC uspGetCustomerTypeID
@Customer_Type_Name = @CustomerTypeName,
@Customer_Type_ID = @CustomerTypeID OUTPUT 
-- Error handle @CustomerTypeID in case if it's NULL/ empty
IF @CustomerTypeID IS NULL
BEGIN
    PRINT  '@CustomerTypeID is empty and will fail in the transaction';
    THROW 51000, '@CustomerTypeID cannot be NULL', 1;
    END 
 
BEGIN TRAN G1
INSERT INTO tblCustomer (CustomerTypeID, CustomerFname, CustomerLname, CustomerPhone, CustomerEmail, CustomerStreetAddr,
                        CustomerCity, CustomerState, CustomerZip)
VALUES (@CustomerTypeID, @Customer_Fname, @Customer_Lname, @Customer_Phone, @Customer_Email, @Customer_Street_Addr, 
                        @Customer_City, @Customer_State, @Customer_Zip)
IF @@ERROR <> 0
BEGIN 
    PRINT 'There is an error; need to rollback this transaction'
    ROLLBACK TRAN G1
    END 
ELSE 
    COMMIT TRAN G1
GO 
 
CREATE PROCEDURE InsertNewOrder
@Customer_FirstName VARCHAR(50),
@Customer_LastName VARCHAR(50),
@Order_Date DATE
AS
DECLARE @CustomerID INT
 
EXEC uspGetCustomerID
@Customer_Fname = @Customer_FirstName,
@Customer_Lname = @Customer_LastName,
@Customer_ID = @CustomerID OUTPUT 
-- Error handle @CustomerID in case if it's NULL/ empty
IF @CustomerID IS NULL
BEGIN     
    PRINT '@CustomerID is empty and will fail in the transaction';
    THROW 51000, '@CustomerID cannot be  NULL', 1;
    END 
    
BEGIN TRAN G1
INSERT INTO tblOrder (CustomerID, OrderDate)
VALUES (@CustomerID, @Order_Date)
IF @@ERROR <> 0
BEGIN
    PRINT 'There is an error; need to rollback this transaction'
    ROLLBACK TRAN G1
    END
ELSE
    COMMIT TRAN G1
    GO
 
CREATE PROCEDURE InsertNewFee
@FeeName VARCHAR(50),
@FeeAmount NUMERIC(8,5),
@FeeDescr VARCHAR(100),
@FeeTypeName VARCHAR(50)
AS
DECLARE @FeeTypeID INT 
 
EXEC uspGetFeeTypeID
@Fee_Type_Name = @FeeTypeName,
@Fee_Type_ID = @FeeTypeID OUTPUT
-- Error handle @FeeTypeID in case if it's NULL/ empty
IF @FeeTypeID IS NULL
BEGIN 
    PRINT '@FeeTypeID is empty and this will cause the transaction to be failed';
    THROW 51000, '@FeeTypeID cannot be NULL', 1;
    END
 
 
INSERT INTO tblFee (FeeName, FeeTypeID, FeeAmount, FeeDescr)
VALUES (@FeeName, @FeeTypeID, @FeeAmount, @FeeDescr)
IF @@ERROR <> 0
BEGIN
    PRINT 'There is an error; need to rollback this transaction'
    ROLLBACK TRAN G1
    END
ELSE
    COMMIT TRAN G1
    GO


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
