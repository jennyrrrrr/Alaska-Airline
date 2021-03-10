-- Views -- 

-- what airports fly most frequently into Seattle
CREATE VIEW vwMost_Frequent_To_Seattle
AS
SELECT TOP(10) A.AirportName, COUNT(*) AS NumFlights
FROM tblAirport A
    JOIN tblFlight F ON F.DepartureAirportID = A.AirportID
GROUP BY A.AirportName
ORDER BY NumFlights DESC
GO 
 
-- how much money customers have spent on orders
CREATE VIEW vwCustomer_Spending
AS
SELECT C.CustomerFname, C.CustomerLname, SUM(B.BookingAmount) AS TotalSpending
FROM tblCustomer C
    JOIN tblOrder O ON O.CustomerID = O.OrderID
    JOIN tblBooking B ON B.OrderID = O.OrderID
GROUP BY C.CustomerID, C.CustomerFname, C.CustomerLname
ORDER BY TotalSpending DESC
GO 

-- which states fly to Hawaii
CREATE VIEW view_flight_to_Hawaii
AS
SELECT F.FlightID,  A.AirportLetters, S.StateName 
    FROM tblFlight F
        JOIN tblAirport A ON A.AirportID = F.ArrivalAirportID
        JOIN tblCity C ON A.CityID = C.CityID
        JOIN tblState S ON S.StateID = C.StateID
        WHERE S.StateName = 'Hawaii'
GO

-- how many airplanes of each type there are in database
CREATE VIEW view_airplanes_per_manufacture
AS
SELECT AM.ManufacturerName, A.AirplaneName, COUNT(A.AirplaneID) AS airplane_count
    FROM tblAirplane_Manufacturer AM
    JOIN tblAirplane A ON A.ManufacturerID = AM.ManufacturerID
    GROUP BY AM.ManufacturerName
GO

-- most frequent events
CREATE VIEW vwMost_Frequent_Events
AS
SELECT TOP(5) E.eventName, COUNT(*) AS EventAmount
FROM tblEvent E
    JOIN tblFlight_Event FE ON FE.EventID = E.EventID
GROUP BY E.eventName
ORDER BY EventAmount DESC
GO 

-- most frequent fees
CREATE VIEW vwMost_Frequent_Fee
AS
SELECT TOP(5) F.FeeName, COUNT(*) AS FeeFreq
FROM tblFee F
    JOIN tblBooking_Fee BF ON BF.FeeID = F.FeeID
GROUP BY F.FeeName
ORDER BY FeeFreq DESC
GO 