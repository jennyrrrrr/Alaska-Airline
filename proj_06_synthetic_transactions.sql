USE ALASKA_AIRLINES
GO
-- Synthetic Transactions -- 


-- wrapper to insert into tblAirplane
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
GO

-- wrapper to insert into tblBooking
CREATE PROCEDURE uspWRAPPER_newBooking
@Run INT 
AS
DECLARE @PassengerCount INT = (SELECT COUNT(*) FROM tblPassenger)
DECLARE @FlightCount INT = (SELECT COUNT(*) FROM tblFlight)
DECLARE @FeeCount INT = (SELECT COUNT(*) FROM tblFee)
DECLARE @OrderCount INT = (SELECT COUNT(*) FROM tblOrder)

DECLARE @PFname VARCHAR(20), @PLname VARCHAR(20), @PDOB DATE, @AT_Name VARCHAR(50), 
@DateM DATE, @FTName VARCHAR(20), @DAirport VARCHAR(5), @AAirport VARCHAR(5), 
@ATime TIME, @DTime TIME, @FHrs FLOAT, @FeeN VARCHAR(20), 
@CFname VARCHAR(20), @CLname VARCHAR(20), @ODate DATE, @BAmount FLOAT

DECLARE @PK INT

WHILE @Run > 0 
BEGIN

SET @PK = (SELECT RAND() * @PassengerCount + 1)
SET @PK = (SELECT RAND() * @FlightCount + 1)
SET @PK = (SELECT RAND() * @FeeCount + 1)
SET @PK = (SELECT RAND() * @OrderCount + 1)
SET @BAmount = (SELECT AreaCode FROM PEEPS.dbo.gthayJUNK2 WHERE CustomerID = @PK)

EXEC [newBooking]
@bookingAmount = @BAmount

SET @Run = @Run - 1
END

EXEC uspWRAPPER_newBooking @Run = 1000;
GO