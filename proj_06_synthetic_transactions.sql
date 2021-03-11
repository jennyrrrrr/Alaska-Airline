USE ALASKAAIRLINES
GO
-- Synthetic Transactions -- 


-- wrapper to insert into tblAirplane
CREATE PROCEDURE uspWRAPPER_newAirplane
@Run INT 
AS
DECLARE @ATypeCount INT = (SELECT COUNT(*) FROM tblAirplane_Type)

DECLARE @AName VARCHAR(50), @ATName VARCHAR(50), @Date_Made DATE, @T_Hrs FLOAT

DECLARE @PK INT
DECLARE @Rand INT

WHILE @Run > 0 
    BEGIN

    SET @PK = (SELECT RAND() * @ATypeCount + 1)
    SET @AName = (SELECT CONCAT(AM.ManufacturerName,' ', A.AirplaneTypeName, CONVERT(VARCHAR, RAND())) 
                    FROM tblAirplane_Manufacturer AM 
                        JOIN tblAirplane_Type A ON A.ManufacturerID = AM.ManufacturerID
                    WHERE A.AirplaneTypeID = @PK)

    SET @PK = (SELECT RAND() * @ATypeCount + 1)
    SET @ATName = (SELECT AirplaneTypeName FROM tblAirplane_Type WHERE AirplaneTypeID = @PK)

    SET @Date_Made = (SELECT GetDate() - (SELECT Rand() * 1000))

    SET @T_Hrs = (SELECT Rand() * 100000)

    EXEC [newAirplane]
    @A_Name = @AName,
    @AType_Name = @ATName, 
    @Date = @Date_Made, 
    @Hrs = @T_Hrs

    SET @Run = @Run - 1
    END
GO

--wrapper for Flight
CREATE PROCEDURE uspWRAPPER_newFlight
@Run INT 
AS
DECLARE @AirplaneCount INT = (SELECT COUNT(*) FROM tblAirplane)
DECLARE @FTypeCount INT = (SELECT COUNT(*) FROM tblFlight_Type)
DECLARE @airCount INT = (SELECT COUNT(*) FROM tblAirport)
DECLARE @TimeCount INT = (SELECT COUNT(*) FROM FlightTime)

DECLARE @FL_Num INT, @Air_Name VARCHAR(50), @FlightTypeName VARCHAR(20), @AirportLtrs_D VARCHAR(5),
@AirportLtrs_A VARCHAR(5), @ArrTime CHAR(10), @DepTime CHAR(10), @FltHours FLOAT

DECLARE @PK INT

WHILE @Run > 0 
    BEGIN

    SET @PK = (SELECT RAND() * @AirplaneCount + 1)
    SET @Air_Name = (SELECT AirplaneName FROM tblAirplane WHERE AirplaneID = @PK)

    SET @PK = (SELECT RAND() * @FTypeCount + 1)
    SET @FlightTypeName = (SELECT FlightTypeName FROM tblFlight_Type WHERE FlightTypeID = @PK)

    SET @PK = (SELECT RAND() * @airCount + 1)
    SET @AirportLtrs_D = (SELECT AirportID FROM tblAirport WHERE AirportLetters = 'SEA')
    SET @AirportLtrs_A = (SELECT AirportID FROM tblAirport WHERE AirportID = @PK)
    SET @FL_Num = (SELECT AreaCode FROM dbo.PEEPS_Customer_Raw  WHERE CustomerID = @PK)

    SET @PK = (SELECT RAND() * @TimeCount + 1)
    SET @ArrTime = (SELECT ArrivalTime FROM FlightTime WHERE RowID = @PK)
    SET @DepTime = (SELECT DepartureTime FROM FlightTime WHERE RowID = @PK)
    SET @FltHours = (SELECT RAND())

    EXEC [newFlight]
    @F_Num = @FL_Num,
    @A_Namea = @Air_Name,
    @FlightType_Name_a = @FlightTypeName,
    @AirportLtrsD = @AirportLtrs_D,
    @AirportLtrsA = @AirportLtrs_A,
    @ArrivalTimea = @ArrTime,
    @DepartureTimea = @DepTime,
    @FlightHrs_a = @FltHours

SET @Run = @Run - 1
END
GO 

-- wrapper for customer
CREATE PROCEDURE usp_wrapper_NewCustomer
@Run INT
AS 
DECLARE @CustomerTypeCount INT = (SELECT COUNT(*) FROM tblCustomer_Type)
DECLARE @PeepsCount INT = (SELECT COUNT(*) FROM dbo.PEEPS_Customer_Raw)

DECLARE @CustomerType_Name VARCHAR(100)

DECLARE @CustomerFname VARCHAR(100), @CustomerLname VARCHAR(100), @CustomerPhone VARCHAR(100),
        @CustomerEmail VARCHAR(100), @CustomerStreetAddr VARCHAR(100), @CustomerCity VARCHAR(100),
        @CustomerState VARCHAR(100), @CustomerZip VARCHAR(100), @CustomerDOB DATE

DECLARE @PK INT 
DECLARE @Rand INT

WHILE @Run > 0 
    BEGIN
        SET @PK = (SELECT RAND()* @CustomerTypeCount + 1)
        SET @CustomerType_Name = (SELECT CustomerTypeName FROM tblCustomer_Type WHERE CustomerTypeID = @PK)

        SET @Rand = (SELECT RAND() * 100)
        SET @CustomerFname = (SELECT CustomerFName FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerLname = (SELECT CustomerLName FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerPhone = (SELECT PhoneNum FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerEmail = (SELECT Email FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerStreetAddr = (SELECT CustomerAddress FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerCity = (SELECT CustomerCity FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerState = (SELECT CustomerState FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerZip = (SELECT CustomerZIP FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)
        SET @CustomerDOB = (SELECT DateOfBirth FROM dbo.PEEPS_Customer_Raw WHERE CustomerID = @PK)

    EXEC [newCustomer]
    @Customer_Fname = @CustomerFname,
    @Customer_Lname = @CustomerLname,
    @Customer_Phone = @CustomerPhone, 
    @Customer_DOB = @CustomerDOB,
    @Customer_Email = @CustomerEmail,
    @Customer_Street_Addr = @CustomerStreetAddr, 
    @Customer_City = @CustomerCity,
    @Customer_State = @CustomerState,
    @Customer_Zip = @CustomerZip, 
    @CustomerTypeName = @CustomerType_Name

    SET @Run = @Run - 1
END
GO

--wrapper for booking
CREATE PROCEDURE uspWRAPPER_newBooking
@Run INT 
AS
DECLARE @PassengerCount INT = (SELECT COUNT(*) FROM tblPassenger)
DECLARE @FlightCount INT = (SELECT COUNT(*) FROM tblFlight)
DECLARE @FeeCount INT = (SELECT COUNT(*) FROM tblFee)
DECLARE @OrderCount INT = (SELECT COUNT(*) FROM tblOrder)
DECLARE @CusCount INT = (SELECT COUNT(*) FROM tblCustomer)

DECLARE @BName VARCHAR(50), @PFname VARCHAR(20), @PLname VARCHAR(20), @PDOB DATE, @FNum INT, @FeeN VARCHAR(20), 
@CFname VARCHAR(20), @CLname VARCHAR(20), @ODate DATE, @BAmount FLOAT

DECLARE @PK INT

WHILE @Run > 0 
    BEGIN

    SET @PK = (SELECT RAND() * @PassengerCount + 1)
    SET @PFname = (SELECT PassengerFname FROM tblPassenger WHERE PassengerID = @PK)
    SET @PLname = (SELECT PassengerLname FROM tblPassenger WHERE PassengerID = @PK)
    SET @PDOB = (SELECT PassengerDOB FROM tblPassenger WHERE PassengerID = @PK)

    SET @PK = (SELECT RAND() * @FlightCount + 1)
    SET @FNum = (SELECT FlightNum FROM tblFlight WHERE FlightID = @PK)

    SET @PK = (SELECT RAND() * @FeeCount + 1)
    SET @FeeN = (SELECT FeeName FROM tblFee WHERE FeeID = @PK)

    SET @PK = (SELECT RAND() * @CusCount + 1)
    SET @CFname = (SELECT CustomerFname FROM tblCustomer WHERE CustomerID = @PK)
    SET @CLname = (SELECT CustomerFname FROM tblCustomer WHERE CustomerID = @PK)

    SET @PK = (SELECT RAND() * @OrderCount + 1)
    SET @ODate = (SELECT OrderDate FROM tblOrder WHERE OrderID = @PK)
    SET @BAmount = (SELECT AreaCode FROM PEEPS.dbo.gthayJUNK2 WHERE CustomerID = @PK)

    SET @BName = CONCAT(@CLname, ' ', CONVERT(VARCHAR, @ODate))

    EXEC [newBooking]
    @Booking_Name = @BName,
    @PassengerFname_ = @PFname,
    @PassengerLname_ = @PLname,
    @PassengerBirth_ = @PDOB,
    @F_Num = @FNum,
    @FeeName_ = @FeeN,
    @CustomerFname_ = @CFname,
    @CustomerLname_ = @CLname,
    @OrderDate_ = @ODate,
    @bookingAmount = @BAmount

    SET @Run = @Run - 1
END

EXEC uspWRAPPER_newBooking @Run = 1000;
GO

CREATE PROCEDURE uspWRAPPER_rongtNewEmployeePosition
    @Run INT
    AS
    DECLARE @EMPLCount INT = (SELECT COUNT(*) FROM tblEMPLOYEE)
    DECLARE @POSITIONCount INT = (SELECT COUNT(*) FROM tblPOSITION)

    DECLARE @EmployeeFnamey VARCHAR(100),
            @EmployeeLnamey VARCHAR(100),
            @EmployeePhoney VARCHAR(100)
    DECLARE @PositionNamey VARCHAR(100)

    DECLARE @PK INT, @Rand INT

    WHILE @Run > 0
        BEGIN
            SET @PK = (SELECT RAND() * @EMPLCount + 1)
            SET @EmployeeFnamey = (SELECT EmployeeFname FROM tblEMPLOYEE WHERE EmployeeID = @PK)
            SET @EmployeeLnamey = (SELECT EmployeeLname FROM tblEMPLOYEE WHERE EmployeeID = @PK)
            SET @EmployeePhoney = (SELECT EmployeePhone FROM tblEMPLOYEE WHERE EmployeeID = @PK)

            SET @PK = (SELECT RAND() * @POSITIONCount + 1)
            SET @PositionNamey = (SELECT PositionName FROM tblPOSITION WHERE PositionID = @PK)

            EXEC newEmployeePosition
            @EF = @EmployeeFnamey,
            @EL = @EmployeeLnamey,
            @EP = @EmployeePhoney,
            @PN = @PositionNamey

            SET @Run = @Run - 1
    END
GO

CREATE PROCEDURE uspWRAPPER_newEvent
    @Run INT
    AS
    DECLARE @ETCount INT = (SELECT COUNT(*) FROM tblEvent_Type)

    DECLARE @ETName VARCHAR(50),
            @EDesc VARCHAR(100), 
            @EName VARCHAR(50)

    DECLARE @PK INT, @Rand INT

    WHILE @Run > 0
        BEGIN
            SET @PK = (SELECT RAND() * @ETCount + 1)
            SET @ETName = (SELECT EventTypeName FROM tblEvent_Type WHERE EventTypeID = @PK)
            SET @EDesc = (SELECT EventTypeDescr FROM tblEvent_Type WHERE EventTypeID = @PK)

            SET @EName = CONCAT(@ETName, ' ', CONVERT(VARCHAR, RAND() + 100))

            EXEC [newEvent]
            @EventT_Name = @ETName,
            @Event_Name = @EName,
            @Event_Descr = @EDesc

            SET @Run = @Run - 1
    END
GO

CREATE PROCEDURE uspWrapper_NewOrder
    @Run INT 
    AS
    DECLARE @CustomerFirstName VARCHAR(100), @CustomerLastName VARCHAR(100), @CustomerBirthdate DATE 
    DECLARE @OrderDate DATE 

    DECLARE @PK INT 
    DECLARE @Rand INT  

    WHILE @Run > 0 
    BEGIN 
        SET @PK = (SELECT RAND() * (300 - 201) + 201)
        SET @CustomerFirstName = (SELECT CustomerFname FROM tblCustomer WHERE CustomerID = @PK)
        SET @CustomerLastName = (SELECT CustomerLname FROM tblCustomer WHERE CustomerID = @PK)
        SET @CustomerBirthdate = (SELECT CustomerDOB FROM tblCustomer WHERE CustomerID = @PK)
    
        SET @Rand = (SELECT RAND() * 100)

        SET @OrderDate = (SELECT GetDate() - (SELECT Rand() * 10000))

    EXEC [newOrder]
    @Customer_FirstName = @CustomerFirstName,
    @Customer_LastName = @CustomerLastName,
    @CustomerDOB = @CustomerBirthdate,
    @Order_Date = @OrderDate 

    SET @Run = @Run - 1
END
GO

CREATE PROCEDURE usp_Wrapper_NewFee
@Run INT 
AS 
DECLARE @FeeTypeCount INT = (SELECT COUNT(*) FROM tblFee_Type)
DECLARE @FeeType_Name VARCHAR(100)

DECLARE @Fee_Name VARCHAR(100), @Fee_Amount FLOAT

DECLARE @PK INT
DECLARE @Rand INT

WHILE @Run > 0
BEGIN 
    SET @PK = (SELECT RAND()* @FeeTypeCount + 1)
    SET @FeeType_Name = (SELECT FeeTypeName FROM tblFee_Type WHERE FeeTypeID = @PK)

    SET @Rand = (SELECT RAND()* 100)

    SET @Fee_Amount = (SELECT RAND() * 1000)

    SET @Fee_Name = (CASE 
    WHEN @Rand < 10 THEN 'Additional checked bag'
    WHEN @Rand BETWEEN 11 AND 15 THEN 'Overweight bag'
    WHEN @Rand BETWEEN 16 AND 20 THEN 'Oversize bag'
    WHEN @Rand BETWEEN 21 AND 25 THEN 'Call center service charge'
    WHEN @Rand BETWEEN 26 AND 30 THEN 'Paper itinerary mailing service charge'
    WHEN @Rand BETWEEN 31 AND 35 THEN 'Partner award booking fee'
    WHEN @Rand BETWEEN 36 AND 40 THEN 'Unaccompanied minor service fee'
    WHEN @Rand BETWEEN 41 AND 45 THEN 'Pet travel fee'
    WHEN @Rand BETWEEN 46 AND 50 THEN 'Ticket receipt research fee'
    WHEN @Rand BETWEEN 51 AND 55 THEN 'Same day confirmed changes'
    WHEN @Rand BETWEEN 56 AND 60 THEN 'Cancellation fee'
    WHEN @Rand BETWEEN 61 AND 65 THEN 'Premium class seats'
    WHEN @Rand BETWEEN 66 AND 70 THEN 'First class paid upgrades'
    WHEN @Rand BETWEEN 71 AND 75 THEN 'Inflight meals and snack boxes'
    WHEN @Rand BETWEEN 76 AND 80 THEN 'Beer, wine, and cocktails'
    WHEN @Rand BETWEEN 81 AND 85 THEN 'Inflight WiFi'
    WHEN @Rand BETWEEN 86 AND 90 THEN 'Left on board item return fee'
    ELSE 'No fee'
    END)

EXEC [newFee]
@FeeName = @Fee_Name,
@FeeAmount = @Fee_Amount,
@FeeTypeName = @FeeType_Name

SET @Run = @Run - 1
END
GO 


CREATE PROCEDURE uspWRAPPER_newBookingFee
@Run INT 
AS
DECLARE @BookingCount INT = (SELECT COUNT(*) FROM tblBooking)
DECLARE @FeeCount INT = (SELECT COUNT(*) FROM tblFee)

DECLARE @Booking_N VARCHAR(50), @Fee_N VARCHAR(50)

DECLARE @PK INT

WHILE @Run > 0 
    BEGIN

    SET @PK = (SELECT RAND() * @BookingCount + 1)
    SET @Booking_N = (SELECT BookingName FROM tblBooking WHERE BookingID = @PK)

    SET @PK = (SELECT RAND() * @FeeCount + 1)
    SET @Fee_N = (SELECT FeeName FROM tblFee WHERE FeeID = @PK)

    EXEC [newBookingFee]
    @Booking_Name = @Booking_N, 
    @Fee_Name = @Fee_N

    SET @Run = @Run - 1
END