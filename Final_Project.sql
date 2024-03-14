USE tempdb

----Table Creation------

CREATE table THUB_UserProfile(
    UserID VARCHAR(10) PRIMARY KEY,
    First_name VARCHAR(10) NOT NULL,
    Last_name VARCHAR(10), 
    Date_of_Birth DATE NOT NULL
)

CREATE TABLE THUB_points(
    TpointID VARCHAR(10) PRIMARY KEY, 
    UserID VARCHAR(10) FOREIGN KEY REFERENCES THUB_UserProfile(UserID), 
    Tpoints INT
)

CREATE TABLE THUB_Social(
    Profile_name VARCHAR(10) PRIMARY KEY,
    content_preference text, 
    Premium_Status varchar(20) NOT NULL,   
    TpointID VARCHAR(10) FOREIGN KEY REFERENCES THUB_points(TpointID)

)


CREATE TABLE Post(
    PostID VARCHAR(20) PRIMARY KEY,
    Profile_name VARCHAR(10) FOREIGN KEY REFERENCES THUB_social(Profile_name),
    postDate DATE
)


CREATE TABLE Post_engagement(
    ReachID VARCHAR(20) PRIMARY KEY, 
    No_Likes INT, 
    No_comments INT, 
    No_shares INT,
    PostID VARCHAR(20) FOREIGN KEY REFERENCES Post(PostID)

)

CREATE TABLE User_Contact(
    ContactID varchar(10) PRIMARY KEY,
    Phone_number INT,
    Email_address varchar(5),
    UserID VARCHAR(10) FOREIGN KEY REFERENCES THUB_UserProfile(UserID)

)

CREATE TABLE Payment_Type(
    UserPayID VARCHAR(10) PRIMARY KEY,
    pay_value text NOT NULL
)

CREATE TABLE User_Account(
    AccountNo varchar(10) PRIMARY KEY, 
    UserPayID VARCHAR(10) FOREIGN KEY REFERENCES Payment_Type(UserPayID),
    UserID VARCHAR(10) FOREIGN KEY REFERENCES THUB_UserProfile(UserID)
)


CREATE TABLE THUB_trading(
    THUB_tradingID VARCHAR(10) PRIMARY KEY,     
    TpointID VARCHAR(10) FOREIGN KEY REFERENCES THUB_Points(TpointID),
    Trading_Points INT    

)


CREATE TABLE Ttrading_Seller(
    SellerID VARCHAR(10) PRIMARY KEY, 
    THUB_tradingID VARCHAR(10) Foreign Key REFERENCES THUB_trading(THUB_tradingID),
    AccountNO varchar(10) FOREIGN KEY REFERENCES User_Account(AccountNO),
    No_Products_Sold INT,
    Seller_rating INT
)


CREATE TABLE Ttrading_Buyer(
    BuyerID VARCHAR(10) PRIMARY KEY, 
    THUB_tradingID VARCHAR(10) Foreign Key REFERENCES THUB_trading(THUB_tradingID),
    AccountNO varchar(10) FOREIGN KEY REFERENCES User_Account(AccountNO),
    No_Products_Bought INT,
    Buyer_rating INT


)


CREATE TABLE Ttrading_Transaction(
    TransactionID VARCHAR(10) PRIMARY KEY, 
    BuyerID VARCHAR(10) FOREIGN KEY REFERENCES Ttrading_Buyer(BuyerID),
    SellerID VARCHAR(10) FOREIGN KEY REFERENCES Ttrading_Seller(SellerID),
    ProductSold Text,
    Agreed_Price INT
)




CREATE TABLE Transaction_delivery(
    TransactionID VARCHAR(10) PRIMARY KEY,
    Order_date DATE,
    Delivery_Status text,
    Delivery_Date DATE   

)

--Add Foreign Key Constraint to TransactionID--

ALTER TABLE Transaction_delivery

ADD FOREIGN KEY (TransactionID) REFERENCES Ttrading_Transaction (TransactionID) 




----Inserting Data into tables----

INSERT into THUB_UserProfile (UserID, First_name, Last_name, Date_of_Birth)

VALUES ('A000000001','Ayokunlemi', 'Badejo', '1996-10-24'), ('A000000123', 'Timi', 'Badejo', '1992-01-27'), ('A000000034', 'Tolu', 'Talor', '1994-10-21')


INSERT INTO THUB_points (TpointID, UserID, Tpoints)

VALUES ('P000000001', 'A000000001', 10), ('P000000123', 'A000000123', 30), ('P000000034', 'A000000034', 40)


INSERT INTO THUB_Social(Profile_name,content_preference,Premium_Status,TpointID)

VALUES ('Ayokay', 'SQL learning', 'Premium', 'P000000001')


INSERT into THUB_trading (THUB_tradingID, TpointID, Trading_Points)

VALUES  ('THT001','P000000001', 1120), ('THT0002', 'P000000123',200), ('THT00005','P000000034', 10000)


INSERT INTO THUB_Social(Profile_name,content_preference,Premium_Status,TpointID)

VALUES ('Taylu', 'Finance', 'Basic', 'P000000034'), ('Timclanks', 'Anime','basic', 'P000000123')





---Reports in THUB social---

SELECT * from THUB_Social

SELECT COUNT(*) as SubscriptionCount, Premium_Status from THUB_Social group BY Premium_Status


---Repost in USer profile---

--Finding Oldest User--


SELECT * FROM THUB_UserProfile 

WHERE Date_of_Birth = (select MIN(Date_of_Birth) from THUB_UserProfile)


--Report on THUb_trading--

--Finding details on who has the most points-- 



SELECT CONCAT(A.First_name, ' ', A.Last_name) as Full_Name, A.Date_of_Birth, A.UserID, max(B.Tpoints)

FROM THUB_UserProfile as A 

LEFT JOIN THUB_points as B 

ON A.UserID = B.UserID


SELECT MAX(Trading_Points) FROM THUB_trading


PRINT 'testing_view'
GO

CREATE or ALTER view [testing_view] AS 

SELECT THUB_tradingID, TpointID

from THUB_trading

WHERE Trading_Points > 1000

go 