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
GO
