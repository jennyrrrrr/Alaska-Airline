USE INFO430_Proj_06
Go

-- tblEmployee

-- new code for get EmployeeID
CREATE PROCEDURE getEmployeeID
@EmployeeFnamey VARCHAR(50),
@EmployeeLnamey VARCHAR(50),
@EmployeeDOBy Date,
@EmployeePhoney VARCHAR(15),
@EmployeeIDy INT OUTPUT
AS
SET @EmployeeIDy = (
   SELECT EmployeeID
   FROM tblEMPLOYEE
   WHERE EmployeeFname = @EmployeeFnamey
       AND EmployeeLname = @EmployeeLnamey
       AND EmployeeDOB = @EmployeeDOBy
       AND EmployeePhone = @EmployeePhoney)
GO

-- new code for newEmployeePosition
CREATE PROCEDURE newEmployeePosition
    @EF VARCHAR(50),
    @EL VARCHAR(50),
    @ED Date,
    @EP VARCHAR(15),
    @PN VARCHAR(50),
    @PD VARCHAR(100)
    AS
        IF @ED > DateADD(Year, -16, GetDate())
            BEGIN
                PRINT 'the employee has to be older than 16 years old'
                RAISERROR ('business rule violation, process is terminating', 11, 1)
                RETURN
            END
    DECLARE @E_ID INT, @P_ID INT

    EXEC getEmployeeID
    @EmployeeFnamey = @EF,
    @EmployeeLnamey = @EL,
    @EmployeeDOBy = @ED,
    @EmployeePhoney = @EP,
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

-- new code for newEmployeePosition
CREATE PROCEDURE newEmployeePosition
    @EF VARCHAR(50),
    @EL VARCHAR(50),
    @ED Date,
    @EP VARCHAR(15),
    @PN VARCHAR(50),
    @PD VARCHAR(100)
    AS
        IF @ED > DateADD(Year, -16, GetDate())
            BEGIN
                PRINT 'the employee has to be older than 16 years old'
                RAISERROR ('business rule violation, process is terminating', 11, 1)
                RETURN
            END
    DECLARE @E_ID INT, @P_ID INT

    EXEC getEmployeeID
    @EmployeeFnamey = @EF,
    @EmployeeLnamey = @EL,
    @EmployeeDOBy = @ED,
    @EmployeePhoney = @EP,
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

-- view for view_flight_to_Hawaii
CREATE VIEW view_flight_to_Hawaii
AS
SELECT F.FlightID,  A.AirportLetters, S.StateName 
    FROM tblFlight F
        JOIN tblAirport A ON A.AirportID = F.ArrivalAirportID
        JOIN tblCity C ON A.CityID = C.CityID
        JOIN tblState S ON S.StateID = C.StateID
        WHERE S.StateName = 'Hawaii'
GO

SELECT * FROM view_flight_to_Hawaii
GO

-- view for view_airplanes_per_manufacture
CREATE VIEW view_airplanes_per_manufacture
AS
SELECT AM.ManufacturerName, COUNT(A.AirplaneID) AS airplane_count
    FROM tblAirplane_Manufacturer AM
    JOIN tblAirplane A ON A.ManufacturerID = AM.ManufacturerID
    GROUP BY AM.ManufacturerName
GO

SELECT * FROM view_airplanes_per_manufacture
GO

-- function for fn_Amount_Flight_per_City
CREATE FUNCTION fn_Amount_Flight_per_City(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT = (
    SELECT Count(F.FlightID) 
        FROM tblFlight F
            JOIN tblAirport A ON A.AirportID = F.ArrivalAirportID
            JOIN tblCity C ON A.CityID = C.CityID
            WHERE C.CityID = @PK
    )
RETURN @RET
END
GO

ALTER TABLE tblCity
ADD Amount_Flight AS (dbo.fn_Amount_Flight_per_City(CityID))

SELECT * FROM tblCity
GO


-- function for fn_Amount_Employee_per_Position
CREATE FUNCTION fn_Amount_Employee_per_Position(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT = (
    SELECT Count(EP.EmployeeID) 
        FROM tblEmployee_Position EP
            JOIN tblPosition P ON P.PositionID = EP.PositionID
            JOIN tblEmployee E ON E.EmployeeID = EP.EmployeeID
            WHERE P.PositionID = @PK
    )
RETURN @RET
END
GO

ALTER TABLE tblPosition
ADD Amount_Employee AS (dbo.fn_Amount_Employee_per_Position(PositionID))

SELECT * FROM tblEmployee
SELECT * FROM tblPosition
SELECT * FROM tblEmployee_Position
SELECT * FROM tblEmployee_Flight
GO

-- SET IDENTITY_INSERT tblPosition ON
-- GO

-- ALTER TABLE tblEmployee
-- DROP 


-- CREATE PROCEDURE uspUpdate_id
-- @Run INT
-- as
--     update tblEmployee set EmployeeID = 1 WHERE EmployeeID = 4

-- syththetic transaction
CREATE PROCEDURE uspWRAPPER_rongtNewEmployeePosition
@Run INT
AS
-- declare variables to manage massive inserts --> get row counts for each look-up table
DECLARE @EMPLCount INT = (SELECT COUNT(*) FROM tblEMPLOYEE)
DECLARE @POSITIONCount INT = (SELECT COUNT(*) FROM tblPOSITION)

-- create variables to be used in the loop
DECLARE 
@EmployeeFnamey VARCHAR(50),
@EmployeeLnamey VARCHAR(50),
@EmployeeDOBy Date,
@EmployeePhoney VARCHAR(15)
DECLARE 
@PositionNamey VARCHAR(50),
@PositionDescry VARCHAR(50)

DECLARE @PK INT -- variable to find a PK value when we do look-ups
DECLARE @Rand INT -- hold integer values for the CASE statement
WHILE @Run > 0
BEGIN

-- find a random value to throw again the participant rowcount
SET @PK = (SELECT RAND() * @EMPLCount + 1)
SET @EmployeeFnamey = (SELECT EmployeeFname FROM tblEMPLOYEE WHERE EmployeeID = @PK)
SET @EmployeeLnamey = (SELECT EmployeeLname FROM tblEMPLOYEE WHERE EmployeeID = @PK)
SET @EmployeeDOBy = (SELECT EmployeeDOB FROM tblEMPLOYEE WHERE EmployeeID = @PK)
SET @EmployeePhoney = (SELECT EmployeePhone FROM tblEMPLOYEE WHERE EmployeeID = @PK)

SET @PK = (SELECT RAND() * @POSITIONCount + 1)
SET @PositionNamey = (SELECT PositionName FROM tblPOSITION WHERE PositionID = @PK)
SET @PositionDescry = (SELECT PositionDescr FROM tblPOSITION WHERE PositionID = @PK)

EXEC newEmployeePosition
@EF = EmployeeFnamey,
@EL = EmployeeLnamey,
@ED = @EmployeeDOBy,
@EP = EmployeePhoney,
@PN = PositionNamey,
@PD = PositionDescry

SET @Run = @Run -1
END

EXEC uspWRAPPER_rongtNewEmployeePosition
@Run = 20

select * from tblEmployee
GO
 