USE ALASKAAIRLINES
GO

-- Get ID Stored Procedures--
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
@EmployeeFnamey VARCHAR(100),
@EmployeeLnamey VARCHAR(100),
@EmployeePhoney VARCHAR(100),
@EmployeeIDy INT OUTPUT
AS
SET @EmployeeIDy = (
    SELECT EmployeeID
    FROM tblEmployee
    WHERE EmployeeFname = @EmployeeFnamey
       AND EmployeeLname = @EmployeeLnamey
       AND EmployeePhone = @EmployeePhoney)
GO
 
CREATE PROCEDURE getPositionID
@PositionNamey VARCHAR(50),
@PositionIDy INT OUTPUT
AS
SET @PositionIDy = 
(SELECT PositionID FROM tblPOSITION WHERE PositionName = @PositionNamey)
GO
 
CREATE PROCEDURE getStateID
@StateNamey VARCHAR(50),
@StateID INT OUTPUT
AS
SET @StateID = 
(SELECT StateID FROM tblSTATE WHERE StateName = @StateNamey)
GO

CREATE PROCEDURE getCustomerTypeID
@CustomerTname VARCHAR(50),
@CustomerT_ID INT OUTPUT
AS
SET @CustomerT_ID = 
(SELECT CustomerTypeID FROM tblCustomer_Type WHERE CustomerTypeName = @CustomerTname)
GO

CREATE PROCEDURE getCustomerID
@Customer_Fname VARCHAR(100),
@Customer_Lname VARCHAR(100),
@Customer_DOB DATE,
@Customer_ID INT OUTPUT
AS
SET @Customer_ID = 
(SELECT TOP(1) CustomerID FROM tblCustomer WHERE CustomerFname = @Customer_Fname AND CustomerLname = @Customer_Lname AND CustomerDOB = @Customer_DOB)
GO

CREATE PROCEDURE getFeeTypeID
@Fee_Type_Name VARCHAR(50),
@Fee_Type_ID INT OUTPUT
AS
SET @Fee_Type_ID = 
(SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = @Fee_Type_Name)
GO

CREATE PROCEDURE getPassengerID
@Passenger_Fname VARCHAR(100),
@Passenger_Lname VARCHAR(100),
@Passenger_Birth DATE,
@Passenger_ID INT OUTPUT
AS
SET @Passenger_ID = 
(SELECT PassengerID FROM tblPassenger WHERE PassengerFname = @Passenger_Fname AND PassengerLname = @Passenger_Lname AND PassengerDOB = @Passenger_Birth)
GO

CREATE PROCEDURE getFlight_TypeID
@FlightType_Name VARCHAR(20),
@FlightType_ID INT OUTPUT
AS 
SET @FlightType_ID = 
(SELECT FlightTypeID FROM tblFlight_Type WHERE FlightTypeName = @FlightType_Name)
GO 

CREATE PROCEDURE getAirportID
@AirportLtrs VARCHAR(5),
@AirportID INT OUTPUT
AS 
SET @AirportID = 
(SELECT AirportID FROM tblAirport WHERE AirportLetters = @AirportLtrs)
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
@EventID INT OUTPUT
AS 
SET @EventID = 
(SELECT EventID FROM tblEvent WHERE EventName = @EventName)
GO 
    
CREATE PROCEDURE getOrderID
    @CustomerFname VARCHAR(100),
    @CustomerLname VARCHAR(100),
    @OrderDate DATE, 
    @OrderID INT OUTPUT
    AS
    DECLARE @CustomerID INT

    EXEC getCustomerID
    @Customer_Fname = @CustomerFname,
    @Customer_Lname = @CustomerFname,
    @Customer_ID = @CustomerID OUTPUT

    -- Error handle @CustomerID in case if it's NULL/empty
    IF @CustomerID IS NULL
    BEGIN 
        PRINT '@CustomerID is empty and this will cause the transaction to be failed';
        THROW 51000, '@CustomerID cannot be NULL', 1;
    END

    SET @OrderID = 
    (SELECT OrderID FROM tblOrder WHERE CustomerID = @CustomerID AND OrderDate = @OrderDate)
GO   

CREATE PROCEDURE getFeeID 
@FeeName VARCHAR(50), 
@FeeID INT OUTPUT
AS
SET @FeeID = 
(SELECT FeeID FROM tblFee WHERE FeeName = @FeeName)
GO

CREATE PROCEDURE getAirplaneID 
@AName VARCHAR(50),
@AirplaneID INT OUTPUT
AS 
SET @AirplaneID = 
(SELECT AirplaneID FROM tblAirplane WHERE AirplaneName = @AName)
GO

CREATE PROCEDURE getBookingID 
@BName VARCHAR(50),
@BookingID INT OUTPUT
AS 
SET @BookingID = 
(SELECT BookingID FROM tblBooking WHERE BookingName = @BName)
GO

CREATE PROCEDURE getFlightID 
@FNum INT,
@FlightID INT OUTPUT
AS 
SET @FlightID = 
(SELECT FlightID FROM tblFlight WHERE FlightNum = @FNum)
GO