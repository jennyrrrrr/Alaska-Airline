USE INFO430_Proj_06
GO


DECLARE @Run INT
SET @Run = 4167
WHILE (@Run >= 1 )
BEGIN 
    INSERT INTO tblEmployee_Position (EmployeeID)
    SELECT EmployeeID FROM tblEmployee WHERE EmployeeFname = ''
    SET @Run = @Run - 1 
END

INSERT INTO INFO430_Proj_06.dbo.tblEmployee_Position(EmployeeID)
SELECT TOP 100000 CustomerID FROM PEEPS.dbo.tblCUSTOMER
ORDER BY CustomerID DESC 


INSERT INTO INFO430_Proj_06.dbo.tblEmployee_Position(EmployeeID)
SELECT EmployeePositionID FROM INFO430_Proj_06.dbo.tblEmployee_Position

------------------------------------------------------------------------

ALTER PROCEDURE InsertNewOrder
@Customer_FirstName VARCHAR(50),
@Customer_LastName VARCHAR(50),
@Customer_Birthdate DATE,
@Order_Date DATE
AS
DECLARE @CustomerID INT
 
EXEC uspGetCustomerID
@Customer_Fname = @Customer_FirstName,
@Customer_Lname = @Customer_LastName,
@Customer_Birth = @Customer_Birthdate,
@Customer_ID = @CustomerID OUTPUT 
-- Error handle @CustomerID in case if it's NULL/ empty
IF @CustomerID IS NULL
BEGIN     
    PRINT '@CustomerID is empty and will fail in the transaction';
    THROW 51000, '@CustomerID cannot be NULL', 1;
    END 
    
BEGIN TRAN G1
INSERT INTO tblOrder (CustomerID, OrderDate)
VALUES (@CustomerID, @Order_Date)
IF @@ERROR <> 0
BEGIN
    PRINT 'There is an error; need to rollback this transaction'
    ROLLBACK TRAN G1
    END
ELSE
    COMMIT TRAN G1
    GO


ALTER PROCEDURE uspWrapper_NewOrder
@Run INT 
AS

-- Declare variables to get row counts for the Customer look-up table (manage largenumber of inserts)
DECLARE @CustomerCount INT = (SELECT COUNT(*) FROM tblCustomer)
-- Create variable(s) to be used in the WHILE loop
DECLARE @CustomerFirstName VARCHAR(50), @CustomerLastName VARCHAR(50),  @CustomerBirthdate DATE 
DECLARE @OrderDate DATE 
DECLARE @PK INT -- Use this variable to find a PK value when doing look-ups
DECLARE @Rand INT  -- Use this variable to hold integer values for the CASE statement
WHILE @Run > 0 
BEGIN 
-- Find a random value to throw against the Fee_Type row count
    SET @PK = (SELECT RAND()* @CustomerCount + 1)
    SET @CustomerFirstName = (SELECT CustomerFname FROM tblCustomer WHERE CustomerID = @PK)
    SET @CustomerLastName = (SELECT CustomerLname FROM tblCustomer WHERE CustomerID = @PK)
    SET @CustomerBirthdate = (SELECT CustomerDOB FROM tblCustomer WHERE CustomerID = @PK)

    SET @Rand = (SELECT RAND()* 100)

    SET @OrderDate = (SELECT GetDate() - (SELECT Rand() * 10000))

EXEC 
@Customer_FirstName = @CustomerFirstName,
@Customer_LastName = @CustomerLastName,
@Customer_Birth = @CustomerBirthdate,
@Order_Date = @OrderDate 

SET @Run = @Run - 1
END



/* For the Customer table, only the CustomerTypeID is allowed for NOT NULL and other attributes are allowed for null. */


/*
INSERT INTO tblFee (FeeName, FeeTypeID, FeeAmount, FeeDescr)
VALUES ('Additional checked bag', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Baggage fees'), '40','Charge for adding one additional bag.')
('Overweight bag', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Baggage fees'), '100', 'Charge for having a 51-100 lbs bag.'),
('Oversize bag', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Baggage fees'),'100', 'Charge for having an oversize bag.'),
('Call center service charge',  (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Reservations and service fees'), '15', 
'Charge for new reservations booked through an Alaska Airlines call center.'),
('Paper itinerary mailing service charge', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Reservations and service fees'), '5',
'Charge when customers choose to receive a paper itinerary.'),
('Partner award booking fee', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Reservations and service fees'), '12.5',
'Charged each way, per award, for all new partner award bookings.'),
('Unaccompanied minor service fee', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Reservations and service fees'), '50', 
'Charge for the service of accompanying a kid or minor is traveling alone.'),
('Pet travel fee', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Reservations and service fees'), '100', 
'Charge for having pets traveling and having them to be in cabin or in the cargo compartment.')
('Same day confirmed changes', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Change and cancellation fees'), '50', 
'Charge for making flight changes on the same day.'),
('Cancellation fee', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Change and cancellation fees'), '25', 
'Charge for cancelling a flight.'),
('Premium class seats', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Inflight fees'), '15', 'Charge for any premium
class seats.'),
('First class paid upgrades', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Inflight fees'), '29', 
'Charge for upgrading to first class seat.'),
('Inflight meals and snack boxes', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Inflight fees'), '10', 
'Charge for any additional meals and snacks for onboard food.'),
('Beer, wine, and cocktails', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Inflight fees'), '12',
'Charge for any beer, wine, or cocktails that are complimentary in Premium Class.'),
('Inflight WiFi', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Inflight fees'), '15', 'Charge for using inflight WiFi.'),
('Left on board itm return fee', (SELECT FeeTypeID FROM tblFee_Type WHERE FeeTypeName = 'Inflight fees'), '20', 'Charge for processing
and shipping fee to mail back items left on board our aircraft.')


INSERT INTO INFO430_Proj_06.dbo.tblCustomer (CustomerFname, CustomerLname, CustomerPhone, CustomerEmail,
                        CustomerStreetAddr, CustomerCity, CustomerState, CustomerZip, CustomerDOB)
SELECT TOP 100000 CustomerFname, CustomerLname, PhoneNum, Email, CustomerAddress, CustomerCity, CustomerState, CustomerZIP, DateofBirth FROM PEEPS.dbo.tblCUSTOMER


CREATE TABLE tblEmployee_Position
(EmployeePositionID INTEGER IDENTITY(1,1) PRIMARY KEY,
EmployeeID INT FOREIGN KEY (EmployeeID) REFERENCES tblEmployee(EmployeeID),
PositionID INT FOREIGN KEY (PositionID) REFERENCES tblPosition(PositionID))
GO

ALTER TABLE tblEmployee_Position
ADD CONSTRAINT FK_EmployeeID
 FOREIGN KEY (EmployeeID) REFERENCES tblEmployee(EmployeeID)
GO

DROP TABLE tblEmployee_Position


SELECT PositionID FROM tblEmployee_Position
WHERE PositionID IS NOT NULL


DECLARE @Run INT
SET @Run = 4159
WHILE (@Run >= 1 )
BEGIN 
    INSERT INTO tblEmployee_Position (PositionID)
    SELECT PositionID FROM tblPosition WHERE PositionName = 'Pilot'
    SET @Run = @Run - 1 
END


DECLARE @Run INT
SET @Run = 20000
WHILE (@Run >= 1 )
BEGIN 
    INSERT INTO tblCustomer (CustomerTypeID)
    SELECT CustomerTypeID FROM tblCustomer_Type WHERE CustomerTypeName = 'Club 49'
    SET @Run = @Run - 1 
END


SELECT COUNT(EmployeeID) -- 100000 rows
FROM tblEmployee  

SELECT COUNT(PassengerID) -- 200000 rows
FROM tblPassenger

DROP TABLE tblCUSTOMER
GO

DROP TABLE tblOrder
GO

DROP TABLE tblBooking
GO

DROP TABLE tblBooking_Fee
GO

CREATE TABLE tblCustomer
(CustomerID INT IDENTITY(1,1) PRIMARY KEY,
CustomerTypeID INT FOREIGN KEY(CustomerTypeID) REFERENCES tblCustomer_Type(CustomerTypeID),
CustomerFname VARCHAR(100) NOT NULL,
CustomerLname VARCHAR(100) NOT NULL,
CustomerPhone VARCHAR(100) NOT NULL,
CustomerEmail VARCHAR(100) NOT NULL,
CustomerStreetAddr VARCHAR(100) NOT NULL,
CustomerCity VARCHAR(100) NOT NULL,
CustomerState VARCHAR(100) NOT NULL,
CustomerZip VARCHAR(100) NOT NULL)   
GO

CREATE TABLE tblOrder
(OrderID INT IDENTITY(1,1) PRIMARY KEY,
CustomerID INT FOREIGN KEY(CustomerID) REFERENCES tblCustomer(CustomerID),
OrderDate DATE NOT NULL)
GO 

CREATE TABLE tblBooking
(BookingID INTEGER IDENTITY(1,1) PRIMARY KEY,
FlightID INT FOREIGN KEY(FlightID) REFERENCES tblFlight(FlightID),
FeeID INT FOREIGN KEY(FeeID) REFERENCES tblFee(FeeID),
OrderID INT FOREIGN KEY(OrderID) REFERENCES tblOrder(OrderID),
EventID INT FOREIGN KEY(EventID) REFERENCES tblEvent(EventID))
GO

CREATE TABLE tblBooking_Fee
(BookingFeeID INTEGER IDENTITY(1,1) PRIMARY KEY,
BookingID INT FOREIGN KEY(BookingID) REFERENCES tblBooking(BookingID),
FeeID INT FOREIGN KEY(FeeID) REFERENCES tblFee(FeeID))
GO

SELECT COUNT(EmployeePositionID) 
FROM tblEmployee_Position

DELETE 
FROM tblEmployee_Position
WHERE PositionID IS NULL
GO

SELECT COUNT(OrderID) 
FROM tblOrder

*/

