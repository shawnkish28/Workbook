create database Techshop;
create table Customers ( CustomerID int primary key,FirstName varchar(50) not null, LastName varchar(50) not null,Email varchar(100) UNIQUE not null,Phone varchar(20),Address varchar(255));


create table Products (ProductID int primary key,ProductName varchar(100) not null,Description varchar(255),Price decimal(10,2) not null,);


create table Orders (orderid int primary key, customerid int not null, orderdate date not null, totalamount decimal(10,2), foreign key (customerid) references customers(customerid));


create table orderdetails (orderdetailid int not null primary key, orderid int not null, productid int not null, quantity int, foreign key (orderid) references orders(orderid), foreign key (productid) references products(productid));


create table inventory ( inventoryid int not null primary key, productid int not null, quantityinstock int, laststockupdate date, foreign key (productid) references products(productid));


insert into Customers values 
(1,'aaaa','aaaa','aaaa@email.com','9876543210','Street 1'),
(2,'bbbb','bbbb','bbbb@email.com','9876543211','Street 2'),
(3,'cccc','cccc','cccc@email.com','9876543212','Street 3'),
(4,'dddd','dddd','dddd@email.com','9876543213','Street 4'),
(5,'eeee','eeee','eeee@email.com','9876543214','Street 5'),
(6,'ffff','ffff','ffff@email.com','9876543215','Street 6'),
(7,'gggg','gggg','gggg@email.com','9876543216','Street 7'),
(8,'hhhh','hhhh','hhhh@email.com','9876543217','Street 8'),
(9,'iiii','iiii','iiii@email.com','9876543218','Street 9'),
(10,'jjjj','jjjj','jjjj@email.com','9876543219','Street 10');

insert into products values
(1,'Laptop','Intel i7,16GB RAM,512GB SSD',65000.00),
(2,'Gaming Mouse','RGB gaming mouse with 6 buttons',2500.00),
(3,'Mechanical Keyboard','Backlit mechanical keyboard',4500.00),
(4,'27-inch Monitor','4K Ultra HD LED Monitor',18000.00),
(5,'Wireless Headphones','Bluetooth noise-cancelling headphones',7500.00),
(6,'External SSD','1TB portable SSD USB 3.1',9500.00),
(7,'Graphics Card','NVIDIA RTX 3060 12GB',28000.00),
(8,'Smartwatch','Fitness tracking smartwatch',5000.00),
(9,'Webcam','HD webcam with mic',2200.00),
(10,'Portable Speaker','Wireless portable speaker',3200.00);

insert into orders values
(1,1,'2025-03-15',87500.00),
(2,2,'2025-03-16',28000.00),
(3,3,'2025-03-17',3500.00),
(4,4,'2025-03-18',13300.00),
(5,5,'2025-03-19',9800.00),
(6,6,'2025-03-20',5200.00),
(7,7,'2025-03-20',8800.00),
(8,8,'2025-03-20',38000.00),
(9,9,'2025-03-20',8200.00),
(10,10,'2025-03-20',3200.00);

insert into orderdetails values
(1,1,1,1),
(2,1,2,1),
(3,2,4,2),
(4,3,2,1),
(5,4,3,2),
(6,4,10,1),
(7,5,6,1),
(8,6,10,3),
(9,7,8,2),
(10,8,7,1);

insert into inventory values
(1,1,15,'2025-03-01'),
(2,2,50,'2025-03-01'),
(3,3,30,'2025-03-01'),
(4,4,20,'2025-03-01'),
(5,5,25,'2025-03-01'),
(6,6,10,'2025-03-01'),
(7,7,5,'2025-03-01'),
(8,8,18,'2025-03-01'),
(9,9,22,'2025-03-01'),
(10,10,28,'2025-03-01');






--1 Write an SQL query to retrieve the names and emails of all customers.
select FirstName, email  from customers;

--2 Write an SQL query to list all orders with their order dates and corresponding customer name
select o.orderid,o.orderdate,c.firstname,c.lastname  
from orders o  
join customers c  
on o.customerid=c.customerid;

--3 Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.
insert into customers values (11,'kkkk','kkkk','kkkk@email.com','9876543341','Street 11');

select * from customers;

--4 Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.
update products set price=price*1.10;

select * from products

--5 Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.
delete from OrderDetails where OrderID = 5;
delete from Orders where OrderID = 5;

select * from orders;

select * from orderdetails

--6. Write an SQL query to insert a new order into the "Orders" table. Include the customer ID,order date, and any other necessary information.

insert into Orders (OrderID, CustomerID, OrderDate, TotalAmount) values (11, 1, '2025-03-21', 12500.00);

select * from  Orders;


--7. Write an SQL query to update the contact information (e.g., email and address) of a specificcustomer in the "Customers" table. Allow users to input the customer ID and new contactinformation.

update Customers set Email = 'abcd@gmail.com',Address = 'street 21' where CustomerID = 3;

select* from Customers;

--8. Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.

update Orders SET TotalAmount = ( select SUM(OD.Quantity * P.Price) FROM OrderDetails OD INNER JOIN Products P ON OD.ProductID = P.ProductID WHERE OD.OrderID = Orders.OrderID);

select * from Orders

--9. Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.
delete from OrderDetails where OrderID IN (select OrderID from Orders where CustomerID = 6);

delete from Orders where CustomerID = 6;

select * from OrderDetails;
select * from Orders;


--10. Write an SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details.
insert into products values (12,'wireless keyboard','electronics',2400.00);
select * from products;

--11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.
alter table orders add status varchar(50);
update orders set status = 'shipped' where orderid = 1;

select * from orders;


--12. Write an SQL query to calculate and update the number of orders placed by each customerin the "Customers" table based on the data in the "Orders" table.

alter table customers add order_count int;
update customers set order_count = (select count(*) from orders where orders.customerid = customers.customerid);

select * from customers;










