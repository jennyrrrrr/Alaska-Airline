USE ALASKAAIRLINES
GO

-- Insert Stored Procedures --
CREATE PROCEDURE newAirplane
@A_Name VARCHAR(50), 
@AType_Name VARCHAR(50), 
@Date DATE, 
@Hrs FLOAT
AS 
DECLARE
@AType_ID INT
 
EXEC getAirplaneTypeID
@AT_Name = @AType_Name, 
@AT_ID = @AType_ID OUTPUT
 
IF @AType_ID IS NULL 
    BEGIN 
        PRINT '@AType_ID cannot be empty - will fail in transaction'; 
        THROW 51100, '@AType_ID cannot be null',1; 
    END
 
BEGIN TRAN T1
    INSERT INTO tblAirplane
    (AirplaneName, AirplaneTypeID, DateMade, TotalFlightHrs)
    VALUES 
    (@A_Name, @AType_ID, @Date, @Hrs)
    IF @@ERROR <> 0
        BEGIN 
            PRINT 'There is an error - rolling back transaction T1'
            ROLLBACK TRAN T1
        END
    ELSE
COMMIT TRAN T1
GO
 
CREATE PROCEDURE newEvent
@EventT_Name VARCHAR(50), 
@Event_Name VARCHAR(50), 
@Event_Descr VARCHAR(100)
AS 
DECLARE
@EventT_ID INT
 
EXEC getEventTypeID
@ET_Name = @EventT_Name, 
@ET_ID = @EventT_ID OUTPUT
 
IF @EventT_ID IS NULL 
    BEGIN 
        PRINT '@EventT_ID cannot be empty - will fail in transaction'; 
        THROW 51300, '@EventT_ID cannot be null',1; 
    END
 
BEGIN TRAN T1
    INSERT INTO tblEvent
    (EventTypeID, EventName, EventDescr)
    VALUES 
    (@EventT_ID, @Event_Name, @Event_Descr)
    IF @@ERROR <> 0
        BEGIN 
            PRINT 'There is an error - rolling back transaction T1'
            ROLLBACK TRAN T1
        END
    ELSE
COMMIT TRAN T1
GO

CREATE PROCEDURE newEmployeePosition
    @EF VARCHAR(100),
    @EL VARCHAR(100),
    @EP VARCHAR(100),
    @PN VARCHAR(50)
    AS
    DECLARE @E_ID INT, @P_ID INT

    EXEC getEmployeeID
    @EmployeeFnamey = @EF,
    @EmployeeLnamey = @EL,
    @EmployeePhoney = @EP,
    @EmployeeIDy = @E_ID OUTPUT
    IF @E_ID IS NULL 
        BEGIN 
            PRINT '@E_ID IS NULL'
            RAISERROR ('@E_ID CAN NOT BE NULL', 11, 1)
            RETURN
        END

    EXEC getPositionID
    @PositionNamey = @PN,
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

CREATE PROCEDURE newCity
    @SN VARCHAR(50), 
    @CN VARCHAR(100)
    AS 
    DECLARE
    @S_ID INT
    
    EXEC getStateID
    @StateNamey = @SN,
    @StateID = @S_ID OUTPUT
    
    IF @S_ID IS NULL 
        BEGIN 
            PRINT '@EventT_ID cannot be empty - will fail in transaction'; 
            THROW 51300, '@EventT_ID cannot be null',1; 
        END
    
    BEGIN TRAN T1
        INSERT INTO tblCity
        (StateID, CityName)
        VALUES 
        (@S_ID, @CN)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error - rolling back transaction T1'
                ROLLBACK TRAN T1
            END
        ELSE
    COMMIT TRAN T1
GO

CREATE PROCEDURE newCustomer 
    @Customer_Fname VARCHAR(100),
    @Customer_Lname VARCHAR(100),
    @Customer_Phone VARCHAR(100),
    @Customer_DOB DATE, 
    @Customer_Email VARCHAR(100),
    @Customer_Street_Addr VARCHAR(100),
    @Customer_City VARCHAR(100),
    @Customer_State VARCHAR(100),
    @Customer_Zip VARCHAR(100),
    @CustomerTypeName VARCHAR(100)
    AS
    DECLARE @CustomerTypeID INT
    
    EXEC getCustomerTypeID
    @CustomerTName = @CustomerTypeName,
    @CustomerT_ID = @CustomerTypeID OUTPUT

    -- Error handle @CustomerTypeID in case if it's NULL/ empty
    IF @CustomerTypeID IS NULL
        BEGIN
            PRINT '@CustomerTypeID is empty and will fail in the transaction';
            THROW 51000, '@CustomerTypeID cannot be NULL', 1;
        END 
    
    BEGIN TRAN G1
        INSERT INTO tblCustomer (CustomerTypeID, CustomerFname, CustomerLname, CustomerPhone, CustomerDOB, CustomerEmail, 
                                CustomerStreetAddr, CustomerCity, CustomerState, CustomerZip)
        VALUES (@CustomerTypeID, @Customer_Fname, @Customer_Lname, @Customer_Phone, @Customer_DOB, @Customer_Email, 
                @Customer_Street_Addr, @Customer_City, @Customer_State, @Customer_Zip)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error; need to rollback this transaction'
                ROLLBACK TRAN G1
            END 
        ELSE 
    COMMIT TRAN G1
GO 

CREATE PROCEDURE newOrder
    @Customer_FirstName VARCHAR(100),
    @Customer_LastName VARCHAR(100),
    @CustomerDOB DATE,
    @Order_Date DATE
    AS
    DECLARE @CustomerID INT
    
    EXEC getCustomerID
    @Customer_Fname = @Customer_FirstName,
    @Customer_Lname = @Customer_LastName,
    @Customer_DOB = @CustomerDOB,
    @Customer_ID = @CustomerID OUTPUT 

    -- Error handle @CustomerID in case if it's NULL/ empty
    IF @CustomerID IS NULL
        BEGIN     
            PRINT '@CustomerID is empty and will fail in the transaction';
            THROW 51000, '@CustomerID cannot be  NULL', 1;
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

CREATE PROCEDURE newFee
    @FeeName VARCHAR(50),
    @FeeAmount FLOAT,
    @FeeTypeName VARCHAR(50)
    AS
    DECLARE @FeeTypeID INT 
    
    EXEC getFeeTypeID
    @Fee_Type_Name = @FeeTypeName,
    @Fee_Type_ID = @FeeTypeID OUTPUT

    -- Error handle @FeeTypeID in case if it's NULL/ empty
    IF @FeeTypeID IS NULL
        BEGIN 
            PRINT '@FeeTypeID is empty and this will cause the transaction to be failed';
            THROW 51000, '@FeeTypeID cannot be NULL', 1;
        END
    
    BEGIN TRAN G1
        INSERT INTO tblFee (FeeName, FeeTypeID, FeeAmount)
        VALUES (@FeeName, @FeeTypeID, @FeeAmount)
        IF @@ERROR <> 0
            BEGIN
                PRINT 'There is an error; need to rollback this transaction'
                ROLLBACK TRAN G1
            END
        ELSE
    COMMIT TRAN G1
GO

CREATE PROCEDURE newFlight
    @F_Num INT, 
    @A_Namea VARCHAR(50),
    @FlightType_Name_a VARCHAR(20), 
    @AirportLtrsD VARCHAR(5),
    @AirportLtrsA VARCHAR(5),
    @ArrivalTimea TIME,
    @DepartureTimea TIME,
    @FlightHrs_a INT
    AS
    DECLARE @AID_a INT, @FLTID_a INT, @DEP_IDa INT, @ARR_IDa INT

    EXEC getAirplaneID
    @AName = @A_Namea,
    @AirplaneID = @AID_a OUTPUT

    -- Error handle @AID_a in case if it's NULL/empty
    IF @AID_a IS NULL
    BEGIN 
        PRINT '@AID_a is empty and this will cause the transaction to be failed';
        THROW 51000, '@AID_a cannot be NULL', 1;
    END

    EXEC getFlight_TypeID
    @FlightType_Name = @FlightType_Name_a,
    @FlightType_ID = @FLTID_a OUTPUT

    -- Error handle @FLTID_a in case if it's NULL/empty
    IF @FLTID_a IS NULL
    BEGIN 
        PRINT '@FLTID_a is empty and this will cause the transaction to be failed';
        THROW 51000, '@FLTID_a cannot be NULL', 1;
    END

    EXEC getAirportID
    @AirportLtrs = @AirportLtrsD,
    @AirportID = @DEP_IDa OUTPUT

    -- Error handle @DEP_ID in case if it's NULL/empty
    IF @DEP_IDa IS NULL
    BEGIN 
        PRINT '@DEP_IDa is empty and this will cause the transaction to be failed';
        THROW 51000, '@DEP_IDa cannot be NULL', 1;
    END

    EXEC getAirportID
    @AirportLtrs = @AirportLtrsA,
    @AirportID = @ARR_IDa OUTPUT

    -- Error handle @ARR_IDa in case if it's NULL/empty
    IF @ARR_IDa IS NULL
    BEGIN 
        PRINT '@ARR_IDa is empty and this will cause the transaction to be failed';
        THROW 51000, '@ARR_IDa cannot be NULL', 1;
    END

    BEGIN TRAN T1
        INSERT INTO tblFlight
        (FlightNum, AirplaneID, FlightTypeID, DepartureAirportID, ArrivalAirportID, ArrivalTime, DepartureTime, FlightHrs)
        VALUES 
        (@F_Num, @AID_a, @FLTID_a, @DEP_IDa, @ARR_IDa, @ArrivalTimea, @DepartureTimea, @FlightHrs_a)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error - rolling back transaction T1'
                ROLLBACK TRAN T1
            END
        ELSE
    COMMIT TRAN T1
GO

CREATE PROCEDURE newBooking
    @Booking_Name VARCHAR(50),
    @PassengerFname_ VARCHAR(100),
    @PassengerLname_ VARCHAR(100),
    @PassengerBirth_ DATE,
    @F_Num INT, 
    @FeeName_ VARCHAR(20),
    @CustomerFname_ VARCHAR(100),
    @CustomerLname_ VARCHAR(100),
    @OrderDate_ DATE, 
    @bookingAmount FLOAT
    AS 
    DECLARE
    @P_ID INT, @F_ID INT, @Fe_ID INT, @O_ID INT
    
    EXEC getPassengerID
    @Passenger_Fname = @PassengerFname_, 
    @Passenger_Lname = @PassengerLname_, 
    @Passenger_Birth = @PassengerBirth_, 
    @Passenger_ID = @P_ID OUTPUT
    
    IF @P_ID IS NULL 
        BEGIN 
            PRINT '@P_ID cannot be empty - will fail in transaction'; 
            THROW 51100, '@P_ID cannot be null',1; 
        END
    
    EXEC getFlightID
    @FNum = @F_Num,
    @FlightID = @F_ID OUTPUT
    
    IF @F_ID IS NULL 
        BEGIN 
            PRINT '@F_ID cannot be empty - will fail in transaction'; 
            THROW 51200, '@F_ID cannot be null',1; 
        END

    EXEC getFeeID
    @FeeName = @FeeName_,
    @FeeID = @Fe_ID OUTPUT
    
    IF @Fe_ID IS NULL 
        BEGIN 
            PRINT '@Fe_ID cannot be empty - will fail in transaction'; 
            THROW 51200, '@Fe_ID cannot be null',1; 
        END
    
    EXEC getOrderID
    @CustomerFname = @CustomerFname_, 
    @CustomerLname = @CustomerLname_,
    @OrderDate = @OrderDate_,
    @OrderID = @O_ID OUTPUT
    
    IF @O_ID IS NULL 
        BEGIN 
            PRINT '@O_ID cannot be empty - will fail in transaction'; 
            THROW 51200, '@O_ID cannot be null',1; 
        END

    BEGIN TRAN T1
        INSERT INTO tblBooking
        (BookingName, PassengerID, FlightID, FeeID, OrderID, BookingAmount)
        VALUES 
        (@Booking_Name, @P_ID, @F_ID, @Fe_ID, @O_ID, @bookingAmount)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error - rolling back transaction T1'
                ROLLBACK TRAN T1
            END
        ELSE
    COMMIT TRAN T1
GO

CREATE PROCEDURE newBookingFee
@Booking_Name VARCHAR(50),
@Fee_Name VARCHAR(50)
AS
DECLARE @BID_ INT, @F_ID_ INT

EXEC getBookingID
@BName = @Booking_Name, 
@BookingID = @BID_ OUTPUT

-- Error handle @PID_ in case if it's NULL/empty
IF @BID_ IS NULL
BEGIN 
    PRINT '@BID_ is empty and this will cause the transaction to be failed';
    THROW 51000, '@BID_ cannot be NULL', 1;
END

EXEC getFeeID
@FeeName = @Fee_Name,
@FeeID = @F_ID_ OUTPUT

-- Error handle @F_ID_ in case if it's NULL/empty
IF @F_ID_ IS NULL
BEGIN 
    PRINT '@F_ID_ is empty and this will cause the transaction to be failed';
    THROW 51000, '@F_ID_ cannot be NULL', 1;
END

BEGIN TRAN T1
    INSERT INTO tblBooking_Fee
    (BookingID, FeeID)
    VALUES 
    (@BID_, @F_ID_)
    IF @@ERROR <> 0
        BEGIN 
            PRINT 'There is an error - rolling back transaction T1'
            ROLLBACK TRAN T1
        END
    ELSE
COMMIT TRAN T1
GO