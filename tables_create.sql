
-- CREATE DATABASE company_restaurant;

CREATE TABLE Users (
    UserId SERIAL PRIMARY KEY,
    UserName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Password VARCHAR(50) NOT NULL,
    Role VARCHAR(50) CHECK(Role IN ('Admin', 'Waiter')) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO Users (UserName, Email, Password, Role) VALUES 
('Alice Smith', 'alice.smith@example.com', 'password123', 'Admin'),
('Bob Johnson', 'bob.johnson@example.com', 'password456', 'Waiter'),
('Charlie Brown', 'charlie.brown@example.com', 'password789', 'Waiter'),
('Diana Prince', 'diana.prince@example.com', 'password321', 'Admin'),
('Eve Adams', 'eve.adams@example.com', 'password654', 'Waiter');


CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(255),
    Address TEXT
); 

INSERT INTO Customers (FirstName, LastName, Phone, Email, Address) VALUES 
('Alice', 'Johnson', '555-123-4567', 'alice.johnson@example.com', '789 Pine Road, Apt 12, Springfield, IL 62706');


CREATE TABLE Categories (
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL,
    Description TEXT
);

INSERT INTO Categories (CategoryName, Description) VALUES 
('Main Courses', 'Main dishes and meals.'),
('Desserts', 'Sweet dishes and desserts.');

CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    CategoryID INTEGER REFERENCES Categories(CategoryID),
    Unit VARCHAR(50) CHECK(Unit IN ('kg', 'lt', 'adet', 'paket')),
    StockQuantity DECIMAL NOT NULL,
    UnitPrice DECIMAL NOT NULL
);

INSERT INTO Products (ProductName, CategoryID, Unit, StockQuantity, UnitPrice) VALUES 
('Orange Juice', 1, 'lt', 30, 2.00);

CREATE TABLE Recipes (
    RecipeID SERIAL PRIMARY KEY,
    RecipeName VARCHAR(255) NOT NULL,
    ProductID INTEGER REFERENCES Products(ProductID),
    Quantity DECIMAL NOT NULL
);

CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INTEGER REFERENCES Customers(CustomerID),
    UserID INTEGER REFERENCES Users(UserID),
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL NOT NULL
);

INSERT INTO Orders (CustomerID, UserID, OrderDate, TotalAmount) VALUES 
(1, 1, '2024-09-01 12:00:00', 15.00);


CREATE TABLE OrderDetails (
    OrderDetailID SERIAL PRIMARY KEY,
    OrderID INTEGER REFERENCES Orders(OrderID),
    ProductID INTEGER REFERENCES Products(ProductID),
    Quantity DECIMAL NOT NULL,
    UnitPrice DECIMAL NOT NULL,
    Amount DECIMAL NOT NULL
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice, Amount) VALUES 
(1, 1, 2, 3.50, 7.00);  -- 1 numaralı siparişe, 1 numaralı üründen 2 adet eklenmiştir


CREATE TABLE StockMovements (
    MovementID SERIAL PRIMARY KEY,
    ProductID INTEGER REFERENCES Products(ProductID),
    Quantity DECIMAL NOT NULL,
    MovementDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    MovementType VARCHAR(50) CHECK(MovementType IN ('Giriş', 'Çıkış')) NOT NULL
);

INSERT INTO StockMovements (ProductID, Quantity, MovementDate, MovementType) VALUES 
(1, -2, '2024-09-01 13:00:00', 'Çıkış');  -- 1 numaralı üründen 2 adet çıkış yapılmıştır


-- SELECT * from Users