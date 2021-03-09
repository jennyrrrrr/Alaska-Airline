-- Insert Stored Procedures 
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
    @PN VARCHAR(50),
    @PD VARCHAR(100)
    AS
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
    @Order_Date DATE
    AS
    DECLARE @CustomerID INT
    
    EXEC uspGetCustomerID
    @Customer_Fname = @Customer_FirstName,
    @Customer_Lname = @Customer_LastName,
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
    @FeeDescr VARCHAR(100),
    @FeeTypeName VARCHAR(50)
    AS
    DECLARE @FeeTypeID INT 
    
    EXEC uspGetFeeTypeID
    @Fee_Type_Name = @FeeTypeName,
    @Fee_Type_ID = @FeeTypeID OUTPUT

    -- Error handle @FeeTypeID in case if it's NULL/ empty
    IF @FeeTypeID IS NULL
        BEGIN 
            PRINT '@FeeTypeID is empty and this will cause the transaction to be failed';
            THROW 51000, '@FeeTypeID cannot be NULL', 1;
        END
    
    BEGIN TRAN G1
        INSERT INTO tblFee (FeeName, FeeTypeID, FeeAmount, FeeDescr)
        VALUES (@FeeName, @FeeTypeID, @FeeAmount, @FeeDescr)
        IF @@ERROR <> 0
            BEGIN
                PRINT 'There is an error; need to rollback this transaction'
                ROLLBACK TRAN G1
            END
        ELSE
    COMMIT TRAN G1
GO
