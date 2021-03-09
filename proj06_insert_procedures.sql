USE ALASKA_AIRLINES
GO

-- Insert Stored Procedures --
CREATE PROCEDURE newAirplane
@AType_Name VARCHAR(50), 
@Date DATE, 
@Hrs FLOAT
AS 
DECLARE
@AType_ID INT, @Manu_ID INT
 
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
    (AirplaneTypeID, DateMade, TotalFlightHrs)
    VALUES 
    (@AType_ID, @Date, @Hrs)
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
    (EventTypeID, EventID, EventDescr)
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
    @EF VARCHAR(50),
    @EL VARCHAR(50),
    @EE VARCHAR(50),
    @EP VARCHAR(15),
    @EA VARCHAR(50),
    @EC VARCHAR(50),
    @ES VARCHAR(50),
    @EZ VARCHAR(50),
    @EB VARCHAR(50),
    @PN VARCHAR(50),
    @PD VARCHAR(100)
    AS
        IF @EB > DateADD(Year, -16, GetDate())
            BEGIN
                PRINT 'the employee has to be older than 16 years old'
                RAISERROR ('business rule violation, process is terminating', 11, 1)
                RETURN
            END
    DECLARE @E_ID INT, @P_ID INT

    EXEC getEmployeeID
    @EmployeeFnamey = @EF,
    @EmployeeLnamey = @EL,
    @EmployeeEmaily = @EE,
    @EmployeePhoney = @EP,
    @EmployeeAddressy = @EA,
    @EmployeeCityy = @EC,
    @EmployeeStatey = @ES,
    @EmployeeZipy = @EZ,
    @EmployeeBirthdayy = @EB,
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

CREATE PROCEDURE newCity
    @SL VARCHAR(50), 
    @SN VARCHAR(50), 
    @CN VARCHAR(100)
    AS 
    DECLARE
    @S_ID INT
    
    EXEC getStateID
    @StateLettersy = @SL, 
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
    @Customer_Fname VARCHAR(50),
    @Customer_Lname VARCHAR(50),
    @Customer_Phone VARCHAR(50),
    @Customer_Email VARCHAR(50),
    @Customer_Street_Addr VARCHAR(50),
    @Customer_City VARCHAR(50),
    @Customer_State VARCHAR(50),
    @Customer_Zip VARCHAR(50),
    @CustomerTypeName VARCHAR(50)
    AS
    DECLARE @CustomerTypeID INT
    
    EXEC getCustomerTypeID
    @Customer_Type_Name = @CustomerTypeName,
    @Customer_Type_ID = @CustomerTypeID OUTPUT

    -- Error handle @CustomerTypeID in case if it's NULL/ empty
    IF @CustomerTypeID IS NULL
        BEGIN
            PRINT '@CustomerTypeID is empty and will fail in the transaction';
            THROW 51000, '@CustomerTypeID cannot be NULL', 1;
        END 
    
    BEGIN TRAN G1
        INSERT INTO tblCustomer (CustomerTypeID, CustomerFname, CustomerLname, CustomerPhone, CustomerEmail, CustomerStreetAddr,
                                CustomerCity, CustomerState, CustomerZip)
        VALUES (@CustomerTypeID, @Customer_Fname, @Customer_Lname, @Customer_Phone, @Customer_Email, @Customer_Street_Addr, 
                                @Customer_City, @Customer_State, @Customer_Zip)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error; need to rollback this transaction'
                ROLLBACK TRAN G1
            END 
        ELSE 
    COMMIT TRAN G1
GO 
 
CREATE PROCEDURE newOrder
    @Customer_FirstName VARCHAR(50),
    @Customer_LastName VARCHAR(50),
    @Customer_DOB DATE,
    @Order_Date DATE
    AS
    DECLARE @CustomerID INT
    
    EXEC getCustomerID
    @Customer_Fname = @Customer_FirstName,
    @Customer_Lname = @Customer_LastName,
    @Customer_DOB = @Customer_DOB,
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
    @FeeAmount NUMERIC(8,5),
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
    @AT_Namea VARCHAR(50),
    @Date_a DATE,
    @FlightType_Name_a VARCHAR(20), 
    @AirportLtrsD VARCHAR(5),
    @AirportLtrsA VARCHAR(5),
    @ArrivalTimea TIME,
    @DepartureTimea TIME,
    @FlightHrs_a INT
    AS
    DECLARE @AID_a INT, @FLTID_a INT, @DEP_IDa INT, @ARR_IDa INT

    EXEC getAirplaneID
    @ATName = @AT_Namea,
    @Date = @Date_a,
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
        (AirplaneID, FlightTypeID, DepartureAirportID, ArrivalAirportID, ArrivalTime, DepartureTime, FlightHrs)
        VALUES 
        (@AID_a, @FLTID_a, @DEP_IDa, @ARR_IDa, @ArrivalTimea, @DepartureTimea, @FlightHrs_a)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error - rolling back transaction T1'
                ROLLBACK TRAN T1
            END
        ELSE
    COMMIT TRAN T1
GO

CREATE PROCEDURE newBooking
    @PassengerFname_ VARCHAR(50),
    @PassengerLname_ VARCHAR(50),
    @PassengerBirth_ DATE,
    @ATName VARCHAR(50),
    @Date DATE,
    @FlightType_Name VARCHAR(20), 
    @DepAirport VARCHAR(5),
    @ArrAirport VARCHAR(5),
    @ArrivalT TIME,
    @DepartureT TIME,
    @FlightHrs INT, 
    @FeeName_ VARCHAR(20),
    @CustomerFname_ VARCHAR(50),
    @CustomerLname_ VARCHAR(50),
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
    @AT_Name = @ATName,
    @Date_= @Date,
    @FlightType_Name_ = @FlightType_Name, 
    @DepAirportLtrs = @DepAirport,
    @ArrAirportLtrs = @ArrAirport,
    @ArrivalTime = @ArrivalT,
    @DepartureTime = @DepartureT,
    @FlightHrs_ = @FlightHrs, 
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
        (PassengerID, FlightID, FeeID, OrderID, BookingAmount)
        VALUES 
        (@P_ID, @F_ID, @Fe_ID, @O_ID, @bookingAmount)
        IF @@ERROR <> 0
            BEGIN 
                PRINT 'There is an error - rolling back transaction T1'
                ROLLBACK TRAN T1
            END
        ELSE
    COMMIT TRAN T1
GO
