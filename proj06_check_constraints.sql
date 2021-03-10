-- Check Constraints -- 

-- must be 18 by order date to make an order if from Washington
CREATE FUNCTION fn_CheckAgeAndState() 
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0 
    IF EXISTS(SELECT O.OrderID
        FROM tblOrder O
            JOIN tblCustomer C ON C.CustomerID = O.CustomerID
        WHERE C.CustomerState = 'Washington'
            AND C.CustomerDOB < DATEADD(Year, -18, O.OrderDate)
        GROUP BY O.OrderID)
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END 
GO

ALTER TABLE tblOrder with nocheck 
ADD CONSTRAINT CK_CheckAgeAndState
CHECK (dbo.fn_CheckAgeAndState() = 0)
GO

-- departure airport must be Seattle
CREATE FUNCTION fn_DepAiportSeattle() 
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0 
    IF EXISTS(SELECT F.DepartureAirportID
        FROM tblFlight F
            JOIN tblAirport A ON A.AirportID = f.DepartureAirportID
            JOIN tblCity C ON C.CityID = A.CityID
        WHERE C.CityName = "Seattle"
        GROUP BY F.DepartureAirportID)
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END 
GO

ALTER TABLE tblFlight with nocheck 
ADD CONSTRAINT CK_DepAirportSeattle
CHECK (dbo.fn_DepAiportSeattle() = 0)
GO

-- arrival time must be greater than departure time
CREATE FUNCTION fn_arivallAndDept() 
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0 
    IF EXISTS(SELECT f.FlightID FROM tblflight f
        WHERE f.DepartureTime > f.ArrivalTime
        GROUP BY f.FlightID)
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END 
GO

ALTER TABLE tblflight with nocheck 
ADD CONSTRAINT CK_arivallAndDept
CHECK (dbo.fn_arivallAndDept() = 0)
GO

--  booking amount must be larger than fee amount
CREATE FUNCTION fn_bookingAndFee() 
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0 
    IF EXISTS(SELECT b.bookingID
        FROM tblBooking b
            JOIN tblFee f ON f.FeeID = b.feeID
        WHERE f.FeeAmount > b.BookingAmount
        GROUP BY b.bookingID)
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END 
GO

ALTER TABLE tblbooking with nocheck 
ADD CONSTRAINT CK_fn_arivallAndDept
CHECK (dbo.fn_arivallAndDept() = 0)
GO


/* Rule #1: No more than 860 passengers can be in a flight departuring from the Sea-Tac airport. */
CREATE FUNCTION fn_NoMoreThan860PassengersInSeattleFlight()
RETURNS INT
AS 
BEGIN 

DECLARE @RET INT = 0
    IF EXISTS (SELECT F.FlightID, F.numPassengers
        FROM tblFlight F 
            JOIN tblAirport A ON F.DepartureAirportID = A.AirportID
    WHERE A.AirportLetters LIKE '%SEA'
    HAVING COUNT(*) > 860)
    BEGIN 
        SET @RET = 1
    END 
RETURN @RET 
END 
GO 

ALTER TABLE tblFlight with NOCHECK
ADD CONSTRAINT CK_NoMoreThan860PassengersInSeattleFlight
CHECK (dbo.fn_NoMoreThan860PassengersInSeattleFlight()=0)
GO 


/* Rule #2: Departure time cannot be earlier than arrival time for a flight  */
CREATE FUNCTION fn_DepartureTimeNotEarlierThanArrialTime()
RETURNS INT
AS 
BEGIN 

DECLARE @RET INT = 0
    IF EXISTS (SELECT F.FlightID, F.ArrivalTime, .DepartureTime
        FROM tblFlight F 
    WHERE       
    HAVING )
    BEGIN 
        SET @RET = 1
    END 
RETURN @RET 
END 
GO 

ALTER TABLE tblFlight with NOCHECK
ADD CONSTRAINT CK_NoMoreThan860PassengersInFlight
CHECK (dbo.fn_NoMoreThan860PassengersInFlight()=0)
GO 

-- check if the employee age is above 16
CREATE FUNCTION fn_CheckEmployeeAge() 
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0 
    IF EXISTS(SELECT E.EmployeeDOB
        FROM tblEmployee E WHERE E.EmployeeDOB < DATEADD(Year, -16, GetDate()))
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END 
GO

ALTER TABLE tblEMPLOYEE with nocheck 
ADD CONSTRAINT CK_CheckEmployeeAge
CHECK (dbo.fn_CheckEmployeeAge() = 0)
GO

-- check if the employee age is above 16
CREATE FUNCTION fn_CheckOrderinBooking() 
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0 
    IF EXISTS(SELECT *
        FROM tblBooking B
            join tblORDER O ON O.OrderID = B.OrderID
            having COUNT(*) > 1000)
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END 
GO

ALTER TABLE tblOrder with nocheck 
ADD CONSTRAINT CK_CheckOrderinBooking
CHECK (dbo.fn_CheckOrderinBooking() = 0)
GO

SELECT * from tblBooking
