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
SET @StateID = 
(SELECT StateID FROM tblSTATE WHERE StateLetters = @StateLettersy AND StateName = @StateNamey)
GO

CREATE PROCEDURE getCustomerID
@Customer_Fname VARCHAR(50),
@Customer_Lname VARCHAR(50),
@Customer_ID INT OUTPUT
AS
SET @Customer_ID = 
(SELECT CustomerID FROM tblCustomer WHERE CustomerFname = @Customer_Fname AND CustomerLname = @Customer_Fname)
GO

CREATE PROCEDURE getFeeTypeID
@Fee_Type_Name VARCHAR(50),
@Fee_Type_ID INT OUTPUT
AS
SET @Fee_Type_ID = 
(SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = @Fee_Type_Name)
GO

CREATE PROCEDURE getPassengerID
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
@FlightType_ID INT OUTPUT
AS 
SET @FlightType_ID = 
(SELECT FlightTypeID FROM tblFlight_Type WHERE FlightTypeName = @FlightType_Name)
GO 

--OrderID, BookingID

--needs to be reviewed 
CREATE PROCEDURE getAirportID
@AirportLtrs VARCHAR(5),
@AirportID INT OUTPUT
AS 
SET @AirportID = 
(SELECT AirportID FROM tblAirport WHERE AirportLetters = @AirportLtrs)
GO 

CREATE PROCEDURE getFlightID
@FlightHrs INT,
@FlightID INT OUTPUT
AS 
SET @FlightID = 
(SELECT FlightID FROM tblFlight WHERE FlightHrs = @FlightHrs)
GO 

CREATE PROCEDURE getFeeID
@FeeName VARCHAR(20), 
@FeeID INT OUTPUT
AS 
SET @FeeID = 
(SELECT FeeID FROM tblFee WHERE FeeName = @FeeName)
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
    @CustomerFname VARCHAR(50),
    @CustomerLname VARCHAR(50),
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
    @FeeTypeName VARCHAR(50),
    @FeeName VARCHAR(50),
    @FeeAmount NUMERIC(8,5), 
    @FeeID INT OUTPUT
    AS 
    DECLARE @FeeTypeID INT
    
    EXEC getFeeTypeID
    @Fee_Type_Name = @FeeTypeName,
    @Fee_Type_ID = @FeeTypeID OUTPUT

    -- Error handle if in case if it's NULL/ empty
    IF @FeeTypeID IS NULL
    BEGIN 
        PRINT '@FeeTypeID is empty and this will cause the transaction to be failed';
        THROW 51000, '@FeeTypeID cannot be NULL', 1;
    END

    SET @FeeID = 
    (SELECT FeeID FROM tblFee WHERE FeeTypeID = @FeeTypeID AND FeeName = @FeeName AND FeeAmount = @FeeAmount)
GO

CREATE PROCEDURE getAirplaneID 
    @ATName VARCHAR(50),
    @Date DATE, 
    @AirplaneID INT OUTPUT
    AS 
    DECLARE @ATID INT
    
    EXEC getAirplaneTypeID
    @AT_Name = @ATName,
    @AT_ID = @ATID OUTPUT

    -- Error handle if in case if it's NULL/ empty
    IF @ATID IS NULL
    BEGIN 
        PRINT '@ATID is empty and this will cause the transaction to be failed';
        THROW 51000, '@ATID cannot be NULL', 1;
    END

    SET @AirplaneID = 
    (SELECT @AirplaneID FROM tblAirplane WHERE AirplaneTypeID = @ATID AND DateMade = @Date)
GO