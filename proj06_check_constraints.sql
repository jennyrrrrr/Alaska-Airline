-- check constraint: Must be 18 by order date to make an order if from Washington
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

-- check constraint: Departure airport must be Seattle
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