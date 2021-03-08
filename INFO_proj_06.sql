USE INFO430_Proj_06
GO

CREATE TABLE tblBooking
(BookingID INTEGER IDENTITY(1,1) PRIMARY KEY,
PassengerID INT NOT NULL,
FlightID INT NOT NULL,
FeeID INT NOT NULL,
OrderID INT NOT NULL,
EventID MONEY NOT NULL)
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
 
--Foreign Key
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
 
ALTER TABLE tblBooking
Add CONSTRAINT FK_EventID
 FOREIGN KEY (EventID) REFERENCES tblEvent(EventID);
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
Add CONSTRAINT FK_FeeID
 FOREIGN KEY (FeeID) REFERENCES tblFee(FeeID);
GO
 
ALTER TABLE tblFlight_Event
Add CONSTRAINT FK_EventID
 FOREIGN KEY (EventID) REFERENCES tblEvent(EventID);
GO
 
ALTER TABLE tblFlight_Event
Add CONSTRAINT FK_FlightID
 FOREIGN KEY (FlightID) REFERENCES tblFlight(FlightID);
GO
 
 
Allison’s Code: 
 
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
 
-- create get id stored procedures
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
    (EventTypeID, EventNameID, EventDescr)
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
 
-- view: What airport flies most frequently into Seattle
CREATE VIEW vwMost_Frequent_To_Seattle
AS
SELECT TOP(10) A.AirportName, COUNT(*) AS NumFlights
FROM tblAirport A
    JOIN tblFlight F ON F.DepartureAirportID = A.AirportID
GROUP BY A.AirportName
ORDER BY NumFlights DESC
GO 
 
-- view: how much money customers have spent 
CREATE VIEW vwCustomer_Spending
AS
SELECT C.CustomerFname, C.CustomerLname, SUM(B.BookingAmount) AS TotalSpending
FROM tblCustomer C
    JOIN tblOrder O ON O.CustomerID = O.OrderID
    JOIN tblBooking B ON B.OrderID = O.OrderID
GROUP BY C.CustomerID, C.CustomerFname, C.CustomerLname
ORDER BY TotalSpending DESC
GO 
 
-- computed column: number of bookings for each order
CREATE FUNCTION fn_numBookingsPerOrder()
RETURNS INTEGER 
AS 
BEGIN 
    DECLARE @RET INT = 
    (SELECT SUM(B.BookingID) 
    FROM tblBooking B 
        JOIN tblOrder O ON O.OrderID = B.BookingID
    GROUP BY O.OrderID) 
RETURN @RET 
END
GO 
 
ALTER TABLE tblOrder 
ADD BookingsInOrder AS (dbo.fn_numBookingsPerOrder())
GO
 
-- computed column: total number of passengers on a flight
CREATE FUNCTION fn_numPassengers()
RETURNS INTEGER 
AS 
BEGIN 
    DECLARE @RET INT = 
    (SELECT SUM(B.PassengerID) 
    FROM tblBooking B 
        JOIN tblFlight F ON F.FlightID = B.FlightID
    GROUP BY F.FlightID) 
RETURN @RET 
END
GO 
 
ALTER TABLE tblFlight
ADD numPassengers AS (dbo.fn_numPassengers())
GO
 
 
Jenny’s Part: 
CREATE TABLE tblEmployee
(EmployeeID INTEGER IDENTITY(1,1) PRIMARY KEY,
EmployeeFname VARCHAR(50) NOT NULL,
EmployeeLname VARCHAR(50) NOT NULL,
EmployeeEmail VARCHAR(50) NOT NULL,
EmployeePhone VARCHAR(15) NOT NULL,
EmployeeAddress VARCHAR(50) NOT NULL,
EmployeeCity VARCHAR(50) NOT NULL,
EmployeeState VARCHAR(50) NOT NULL,
EmployeeZip VARCHAR(50) NOT NULL,)
GO
CREATE TABLE tblEmployee_Flight
(EmployeeFlightID INTEGER IDENTITY(1,1) PRIMARY KEY,
FlightID INT NOT NULL,
EmployeeID INT NOT NULL)
GO
CREATE TABLE tblEmployee_Position
(EmployeePositionID INTEGER IDENTITY(1,1) PRIMARY KEY,
EmployeeID INT NOT NULL,
PostionID INT NOT NULL)
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
ALTER TABLE tblEmployee_Position
ADD FOREIGN KEY (EmployeeID) REFERENCES tblEmployee(EmployeeID)
GO
 
ALTER TABLE tblEmployee_Position
ADD FOREIGN KEY (PositionID) REFERENCES tblPosition(PositionID)
GO
ALTER TABLE tblEmployee_Flight
ADD FOREIGN KEY (FlightID) REFERENCES tblEmployee_Flight(FlightID);
GO
ALTER TABLE tblEmployee_Flight
ADD FOREIGN KEY (EmployeeID) REFERENCES tblEmployee_Flight(EmployeeID);
GO
ALTER TABLE tblCity
ADD FOREIGN KEY (StateID) REFERENCES tblState(StateID);
GO
 
-- get id procedure
CREATE PROCEDURE getEmployeeID
@EmployeeFnamey VARCHAR(50),
@EmployeeLnamey VARCHAR(50),
@EmployeeEmaily VARCHAR(50),
@EmployeePhoney VARCHAR(15),
@EmployeeAddressy VARCHAR(50),
@EmployeeCityy VARCHAR(50),
@EmployeeStatey VARCHAR(50),
@EmployeeZipy VARCHAR(50),
@EmployeeIDa OUTPUT
AS
SET @EmployeeIDa = (
   SELECT EmployeeID
   FROM tblEMPLOYEE
   WHERE @EmployeeFname = @EmployeeFnamey
       AND @EmployeeLnamey = @EmployeeLnamey
       AND @EmployeeEmaily = @EmployeeEmaily
       AND @EmployeePhoney = @EmployeePhoney
       AND @EmployeeAddressy = @EmployeeAddressy
       AND @EmployeeCityy = @EmployeeCityy
       AND @EmployeeStatey = @EmployeeStatey
       AND @EmployeeZipy = @EmployeeZipy)
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
@StateIDa OUTPUT
AS
SET @StateIDa = (
   SELECT StateID
   FROM tblSTATE
   WHERE @StateLetters = @StateLettersy
       AND @StateName = @StateNamey)
GO
-- insert procedure
CREATE PROCEDURE rongtNewEmployeePosition
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
@EF2 = @EF,
@EL2 = @EL,
@EE2 = @EE,
@EP2 = @EP,
@EA2 = @EA,
@EC2 = @EC,
@ES2 = @ES,
@EZ2 = @EZ,
@E_ID2 = @E_ID OUTPUT
IF @E_ID IS NULL
   BEGIN
       PRINT '@E_ID IS NULL'
       RAISERROR ('@E_ID CAN NOT BE NULL', 11, 1)
       RETURN
   END
 
EXEC getPostionID
@PN2 = @PN,
@PD2 = @PD,
@P_ID2 = @P_ID OUTPUT
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
 
 
Wanyu’s code:
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
 
CREATE TABLE tblFee
(FeeID INT IDENTITY(1,1) PRIMARY KEY,
FeeName VARCHAR(50) NOT NULL,
FeeTypeID INT FOREIGN KEY(FeeTypeID) REFERENCES tblFee_Type(FeeTypeID),
FeeAmount NUMERIC(8,5) NOT NULL,
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
 
 
 
-- Get id procedures
 
CREATE PROCEDURE uspGetCustomerTypeID
@Customer_Type_Name VARCHAR(100),
@Customer_Type_ID INT OUTPUT
AS
SET @Customer_Type_ID = (SELECT CustomerTypeID FROM tblCustomer_Type WHERE CustomerTypeName = @Customer_Type_Name)
 
 
CREATE PROCEDURE uspGetCustomerID
@Customer_Fname VARCHAR(50),
@Customer_Lname VARCHAR(50),
@Customer_Birth DATE,
@Customer_ID INT OUTPUT
AS
SET @Customer_ID = (SELECT CustomerID FROM tblCustomer WHERE CustomerFname = @Customer_Fname
                                                        AND CustomerLname = @Customer_Fname
                                                        AND CustomerBirth = @Customer_Birth)
 
CREATE PROCEDURE uspGetOrderID
@CustomerFname VARCHAR(50),
@CustomerLname VARCHAR(50),
@CustomerBirth DATE,
@OrderDate DATE
AS
DECLARE @CustomerID INT 
 
EXEC uspGetCustomerID
@Customer_Fname = @CustomerFname,
@Customer_Lname = @CustomerFname,
@Customer_Birth = @CustomerBirth,
@Customer_ID = @CustomerID OUTPUT
-- Error handle @CustomerID in case if it's NULL/empty
IF @CustomerID IS NULL
BEGIN 
    PRINT '@CustomerID is empty and this will cause the transaction to be failed';
    THROW 51000, '@CustomerID cannot be NULL', 1;
    END
    
--------------------------------------------------------------
 
CREATE PROCEDURE uspGetFeeTypeID
@Fee_Type_Name VARCHAR(50),
@Fee_Type_ID INT OUTPUT
AS
SET @Fee_Type_ID = (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = @Fee_Type_Name)
 
--------------------------------------------------------------
 
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
 
---------------------------------------------------------------
 
CREATE PROCEDURE uspGetPassengerID
@Passenger_Fname VARCHAR(50),
@Passenger_Lname VARCHAR(50),
@Passenger_Birth DATE,
@Passenger_ID INT OUTPUT
AS
@Passenger_ID = (SELECT PassengerID FROM tblPassenger WHERE PassengerFname = @Passenger_Fname
                                                        AND PassengerLname = @Passenger_Lname
                                                        AND PassengerBirth = @Passenger_Birth)
 
---------------------------------------------------------------
 
 
-- Insert Stored Procedures 
 
CREATE PROCEDURE InsertNewCustomer 
@Customer_Fname VARCHAR(50),
@Customer_Lname VARCHAR(50),
@Customer_Phone VARCHAR(50),
@Customer_Email VARCHAR(50),
@Customer_Street_Addr VARCHAR(50),
@Customer_City VARCHAR(50),
@Customer_State VARCHAR(50),
@Customer_Zip VARCHAR(50),
@Customer_Birth DATE,
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
                        CustomerCity, CustomerState, CustomerZip, CustomerBirth)
VALUES (@CustomerTypeID, @Customer_Fname, @Customer_Lname, @Customer_Phone, @Customer_Email, @Customer_Street_Addr, 
                        @Customer_City, @Customer_State, @Customer_Zip, @Customer_Birth)
IF @@ERROR <> 0
BEGIN 
    PRINT 'There is an error; need to rollback this transaction'
    ROLLBACK TRAN G1
    END 
ELSE 
    COMMIT TRAN G1
GO 
 
----------------------------------------------
 
CREATE PROCEDURE InsertNewOrder
@Customer_FirstName VARCHAR(50),
@Customer_LastName VARCHAR(50),
@Customer_Birthdate DATE,
@Order_Date DATE
AS
DECLARE @CustomerID INT
 
EXEC uspGetCustomerID
@Customer_Fname = @Customer_FirstName,
@Customer_Lname = @Customer_LastName,
@Customer_Birth = @Customer_Birthdate,
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
 
------------------------------------------------
 
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
 
