-- Computed Columns --

-- number of bookings for each order
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
 
-- total number of passengers on a flight
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

-- number of flights per city 
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

-- number of employees per position 
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

-- number of airplanes per manufacture
CREATE FUNCTION fn_numManuAirplanes()
RETURNS INTEGER 
AS 
BEGIN 
    DECLARE @RET INT = 
    (SELECT SUM(a.AirplaneID) 
    FROM tblAirplane a
        JOIN tblAirplane_Manufacturer af ON af.ManufacturerID = a.ManufacturerID
    GROUP BY af.ManufacturerID) 
RETURN @RET 
END
GO 
 
ALTER TABLE tblAirplane_Manufacturer
ADD Airplanes_per_Manu AS (dbo.fn_numManuAirplanes())
GO

-- number of cancellations and delays
CREATE FUNCTION fn_DelaysAndCancelled()
RETURNS INTEGER 
AS 
BEGIN 
    DECLARE @RET INT = 
    (SELECT SUM(FE.FlightEventID) 
    FROM tblFlight_Event fe
        JOIN tblEvent e ON e.EventID = fe.EventID
        JOIN tblEvent_Type et ON et.EventTypeID = e.EventTypeID
    GROUP BY e.EventTypeID) 
RETURN @RET 
END
GO 
 
ALTER TABLE tblEvent_Type
ADD numCancelledAndDelayed AS (dbo.fn_DelaysAndCancelled())
GO


/* Computed column #1: Average number of flights flying from Seattle per day. */
CREATE FUNCTION fn_AverageFlightsFromSeattlePerDay(@PK INT)
RETURNS INT 
AS 
BEGIN 

DECLARE @RET INT = (SELECT AVG(COUNT(F.FlightID)) AS AverageNumFlights
    FROM tblFlight F
        JOIN tblAirport A ON F.DepartureAirportID = A.AirportID
    WHERE A.AirportID = @PK
    AND A.AirportLetters LIKE '%SEA%')
RETURN @RET
END 
GO 

ALTER TABLE tblAirport
ADD AverageNumFlights AS (dbo.fn_AverageFlightsFromSeattlePerDay(AirportID))


/* Computed column #2: Total booking amount per order for the order table. */
CREATE FUNCTION fn_TotalBookingAmount(@PK INT)
RETURNS INT 
AS 
BEGIN 

DECLARE @RET INT = (SELECT SUM(B.BookingAmount) AS TotalBookingAmount
    FROM tblBooking B
        JOIN tblOrder O ON B.OrderID = B.OrderID
    WHERE O.OrderID = @PK)
RETURN @RET
END 
GO

ALTER TABLE tblOrder
ADD TotalBookingAmount AS (dbo.fn_TotalBookingAmount(OrderID))
