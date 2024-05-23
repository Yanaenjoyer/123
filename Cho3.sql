
-- Создание базы данных
CREATE DATABASE TradingDB;
GO

USE TradingDB;
GO

-- Создание таблицы Customers
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50) NULL,
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100) NOT NULL
);
GO

-- Создание таблицы Employees
CREATE TABLE Employees (
    EmployeeID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50) NULL,
    BirthDate DATE NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Street NVARCHAR(50) NOT NULL,
    House NVARCHAR(20) NOT NULL,
    Apartment NVARCHAR(10) NULL
);
GO

-- Создание таблицы Products
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    Article NVARCHAR(50) NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Image NVARCHAR(MAX) NULL,
    Unit NVARCHAR(20) NOT NULL,
    ManufactureDate DATE NOT NULL,
    ExpiryDate DATE NOT NULL,
    ManufacturerFirm NVARCHAR(50) NOT NULL,
    ManufacturerCountry NVARCHAR(50) NOT NULL
);
GO

-- Создание таблицы OrderStatuses
CREATE TABLE OrderStatuses (
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    StatusName NVARCHAR(50) NOT NULL
);
GO

-- Создание таблицы Orders
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    StatusID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (StatusID) REFERENCES OrderStatuses(StatusID)
);
GO

-- Создание таблицы OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Создание таблицы Sales
CREATE TABLE Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    SaleDate DATE NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL,
    EmployeeID UNIQUEIDENTIFIER NOT NULL,
    CustomerID INT NOT NULL,
    OrderID INT NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
GO

-- Создание таблицы Promotions
CREATE TABLE Promotions (
    PromotionID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    PromotionDetails NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

-- Вставка тестовых данных
INSERT INTO Customers (FirstName, LastName, MiddleName, Phone, Email)
VALUES ('John', 'Doe', 'A', '1234567890', 'john.doe@example.com'),
       ('Jane', 'Smith', NULL, '0987654321', 'jane.smith@example.com');

INSERT INTO Employees (FirstName, LastName, MiddleName, BirthDate, Phone, City, Street, House, Apartment)
VALUES ('Alice', 'Johnson', NULL, '1980-01-01', '1122334455', 'New York', '5th Ave', '10', '101'),
       ('Bob', 'Brown', 'B', '1990-05-15', '5566778899', 'Los Angeles', 'Sunset Blvd', '20', '202');

INSERT INTO Products (Article, Name, Category, Price, Image, Unit, ManufactureDate, ExpiryDate, ManufacturerFirm, ManufacturerCountry)
VALUES ('A001', 'Product A', 'Category 1', 10.00, NULL, 'Piece', '2023-01-01', '2024-01-01', 'Firm A', 'Country A'),
       ('B002', 'Product B', 'Category 2', 20.00, NULL, 'Piece', '2023-02-01', '2024-02-01', 'Firm B', 'Country B');

INSERT INTO OrderStatuses (StatusName)
VALUES ('New'), ('In Progress'), ('Completed');

INSERT INTO Orders (OrderDate, CustomerID, StatusID)
VALUES ('2024-01-01', 1, 1),
       ('2024-01-02', 2, 2),
       ('2024-01-03', 1, 3),
       ('2024-01-04', 2, 1),
       ('2024-01-05', 1, 2),
       ('2024-01-06', 2, 3),
       ('2024-01-07', 1, 1),
       ('2024-01-08', 2, 2),
       ('2024-01-09', 1, 3),
       ('2024-01-10', 2, 1);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES (1, 1, 5),
       (1, 2, 3),
       (2, 1, 2),
       (2, 2, 1),
       (3, 1, 4),
       (3, 2, 2),
       (4, 1, 3),
       (4, 2, 2),
       (5, 1, 1),
       (5, 2, 5);

INSERT INTO Sales (SaleDate, PaymentMethod, EmployeeID, CustomerID, OrderID)
VALUES ('2024-01-11', 'Credit Card', (SELECT TOP 1 EmployeeID FROM Employees ORDER BY NEWID()), 1, 1),
       ('2024-01-12', 'Cash', (SELECT TOP 1 EmployeeID FROM Employees ORDER BY NEWID()), 2, 2),
       ('2024-01-13', 'Credit Card', (SELECT TOP 1 EmployeeID FROM Employees ORDER BY NEWID()), 1, 3),
       ('2024-01-14', 'Cash', (SELECT TOP 1 EmployeeID FROM Employees ORDER BY NEWID()), 2, 4),
       ('2024-01-15', 'Credit Card', (SELECT TOP 1 EmployeeID FROM Employees ORDER BY NEWID()), 1, 5),
       ('2024-01-16', 'Cash', (SELECT TOP 1 EmployeeID FROM Employees ORDER BY NEWID()), 2, 6),
       ('2024-01-17', 'Credit Card', (SELECT TOP 1 EmployeeID FROM Employees ORDER BY NEWID()), 1, 7),
       ('2024-01-18', 'Cash', (SELECT TOP 1 EmployeeID FROM Employees ORDER BY NEWID()), 2, 8),
       ('2024-01-19', 'Credit Card', (SELECT TOP 1 EmployeeID FROM Employees ORDER BY NEWID()), 1, 9),
       ('2024-01-20', 'Cash', (SELECT TOP 1 EmployeeID FROM Employees ORDER BY NEWID()), 2, 10);

INSERT INTO Promotions (CustomerID, PromotionDetails)
VALUES (1, '10% off on next purchase'),
       (2, '15% off on next purchase');
GO

-- Создание процедуры для проверки корректности email
CREATE PROCEDURE CheckEmailValidity
AS
BEGIN
    SELECT 
        Email,
        CASE 
            WHEN Email LIKE '%[^a-zA-Z0-9@._]%' OR
                 Email NOT LIKE '%@%.__%' OR
                 Email LIKE '%@%@%' OR
                 Email LIKE '%..%' OR
                 Email LIKE '%@.%' OR
                 Email LIKE '%.@%' THEN 0
            ELSE 1
        END AS IsValid
    FROM Customers;
END;
GO

-- Запуск процедуры
EXEC CheckEmailValidity;
GO

-- Создание таблицы HistoryCost
CREATE TABLE HistoryCost (
    ChangeDate DATETIME DEFAULT GETDATE(),
    ProductID INT NOT NULL,
    OldPrice DECIMAL(10, 2) NOT NULL,
    NewPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Создание триггера для записи изменений цен
CREATE TRIGGER trg_ProductPriceUpdate
ON Products
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Price)
    BEGIN
        INSERT INTO HistoryCost (ProductID, OldPrice, NewPrice)
        SELECT 
            i.ProductID, 
            d.Price AS OldPrice, 
            i.Price AS NewPrice
        FROM 
            inserted i
        JOIN 
            deleted d ON i.ProductID = d.ProductID;
    END
END;
GO

USE TradingDB;
GO

SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    SUM(od.Quantity * p.Price) AS TotalAmount
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
GROUP BY 
    c.CustomerID, c.FirstName, c.LastName, o.OrderID, o.OrderDate
ORDER BY 
    c.CustomerID, o.OrderID;
GO

USE TradingDB;
GO
DELETE FROM Products
WHERE ExpiryDate < GETDATE();
GO

USE TradingDB;
GO
UPDATE Products
SET Price = Price * 0.75
WHERE ManufacturerCountry = 'Russia';
GO
