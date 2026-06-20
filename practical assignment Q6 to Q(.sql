## question 6:

create database ECommerceDB;

use ECommerceDB;

create table Categories(CategoryID INT PRIMARY KEY,CategoryName VARCHAR(50) NOT NULL UNIQUE);

create table Products(ProductID INT PRIMARY KEY, 
ProductName VARCHAR(100) NOT NULL UNIQUE,
CategoryID int,
constraint category foreign key(categoryID) references categories(categoryID), 
Price DECIMAL(10,2) NOT NULL,
StockQuantity INT );

create table Customers( CustomerID INT PRIMARY KEY, 
CustomerName VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE,
JoinDate DATE); 

create table Orders(OrderID INT PRIMARY KEY, 
CustomerID INT,
constraint customer FOREIGN KEY(CustomerID) references  Customers(customerID),
OrderDate DATE NOT NULL,
TotalAmount DECIMAL(10,2));


insert into categories(categoryID,categoryName) 
values
(1,"Electronics"),(2,"Books"),(3,"Home Goods"),(4,"Apparel");

select * from categories;

insert into Products(ProductID,ProductName,CategoryID,Price,StockQuantity) 
values
(101,"Laptop Pro",1,1200.00,50),
(102,"SQL Handbook",2,45.50,200),
(103,"Smart Speaker",1,99.99 ,150),
(104,"Coffee Maker",3,75.00 ,80),
(105,"Novel : The Great SQL",2,25.00 ,120),
(106,"Wireless Earbuds",1,150.00 ,100),
(107,"Blender X",3,120.00 ,60),
(108,"T-Shirt Casual",4,20.00 ,300);

select * from products;

insert into customers(CustomerID,CustomerName,Email,JoinDate)
values (1,"Alice Wonderland","alice@example.com",'2023-01-10'),
(2,"Bob the Builder","bob@example.com",'2022-11-25'),
(3,"Charlie Chaplin","charlie@example.com ",'2023-03-01'),
(4,"Diana Prince ","diana@example.com ",'2021-04-26');

select * from customers;

insert into Orders (OrderID,CustomerID,	OrderDate ,	TotalAmount )
values(1001,1,'2023-04-26',1245.50 ),(1002,2 ,'2023-10-12',	99.99), 
(1003,1,'2023-07-01' ,145.00 ),
(1004,3,'2023-01-14',150.00 ),
(1005,2,'2023-09-24',120.00 ),
(1006,1,'2023-06-19',20.00 );


##question 07 : 
##Generate a report showing CustomerName, Email, and the TotalNumberofOrders for each customer. 
## Include customers who have not placed any orders, in which case their TotalNumberofOrders should be 0.
## Order the results by CustomerName. 

use ecommercedb;

select c.CustomerName,c.Email,count(o.orderId) as number_of_orders
from customers c left join orders o
 on c.customerID = o.customerID
group by c.customerID 
order by customerName;


## question 8:
##Retrieve Product Information with Category: Write a SQL query to display the ProductName, Price, StockQuantity, and CategoryName 
##for all products. Order the results by CategoryName and then ProductName alphabetically. 

select p.ProductName,p.Price,p.StockQuantity,c.CategoryName 
from products p left join categories c 
on p.categoryID = c.categoryID
order by categoryName,ProductName;


##Question 9 :
## Write a SQL query that uses a Common Table Expression (CTE) and a 
##Window Function (specifically ROW_NUMBER() or RANK()) to display the 
##CategoryName, ProductName, and Price for the top 2 most expensive products in each CategoryName. 

##CTE

select  CategoryName,ProductName,Price, dense_rank() over(partition by CategoryName order by Price DESC) AS PriceRank
FROM products join categories on products.categoryID = categories.categoryID;

## query using CTE and window function(rank)

with ranks as
(select  CategoryName,ProductName,Price, dense_rank() over(partition by CategoryName order by Price DESC) AS PriceRank
FROM products join categories on products.categoryID = categories.categoryID)
SELECT CategoryName,ProductName,price FROM Ranks
WHERE PriceRank <= 2;
    

