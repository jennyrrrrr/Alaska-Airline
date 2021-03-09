-- view: What airport flies most frequently into Seattle
CREATE VIEW vwMost_Frequent_To_Seattle
AS
SELECT TOP(10) A.AirportName, COUNT(*) AS NumFlights
FROM tblAirport A
    JOIN tblFlight F ON F.DepartureAirportID = A.AirportID
GROUP BY A.AirportName
ORDER BY NumFlights DESC
GO 
 
-- view: how much money customers have spent 
CREATE VIEW vwCustomer_Spending
AS
SELECT C.CustomerFname, C.CustomerLname, SUM(B.BookingAmount) AS TotalSpending
FROM tblCustomer C
    JOIN tblOrder O ON O.CustomerID = O.OrderID
    JOIN tblBooking B ON B.OrderID = O.OrderID
GROUP BY C.CustomerID, C.CustomerFname, C.CustomerLname
ORDER BY TotalSpending DESC
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

-- view for view_airplanes_per_manufacture
CREATE VIEW view_airplanes_per_manufacture
AS
SELECT AM.ManufacturerName, COUNT(A.AirplaneID) AS airplane_count
    FROM tblAirplane_Manufacturer AM
    JOIN tblAirplane A ON A.ManufacturerID = AM.ManufacturerID
    GROUP BY AM.ManufacturerName
GO
