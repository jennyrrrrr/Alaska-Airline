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