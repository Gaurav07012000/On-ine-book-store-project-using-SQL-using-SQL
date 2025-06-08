CREATE DATABASE OnlineBookstore;
USE Onlinebookstore;

CREATE TABLE Books(
Book_ID	int PRIMARY KEY,
Title	VARCHAR(100),
Author	VARCHAR(100),
Genre	VARCHAR(50),
Published_Year	INT,
Price	NUMERIC(10,2),
Stock	INT
);

CREATE TABLE Customers(
Customer_ID	INT PRIMARY KEY,
Name	VARCHAR(100),
Email	VARCHAR(100),
Phone	VARCHAR(15),
City	VARCHAR(50),
Country	VARCHAR(150)
);

CREATE TABLE Orders(
Order_ID	INT PRIMARY KEY,
Customer_ID	INT REFERENCES Customers(Customer_ID), 
Book_ID	INT REFERENCES Books(Books_ID),
Order_Date	DATE,
Quantity INT,
Total_Amount numeric(10,2)
);

Select * from Books;
Select * from Customers;
Select * from Orders;

-- Basic Queries
-- 1) Retrieve all the functions in the fiction genre:
select * from Books
where genre = "Fiction";

-- 2) Find book published after year 1950:
select * from Books
where Published_Year > 1950;

-- 3) List all the customers from Canada:
select * from Customers
where Country = "Canada"

-- 4) Show orders placed in Novermber 2023:
Select * from orders
where order_date BETWEEN "2023-11-01" AND "2023-11-30";

-- 5)Retrieve the total stock of books available:
select sum(stock) as total_stock
from Books;

-- 6) Find the details of the most expensive book:
select * from Books
order by price desc limit 1;

-- 7) Sow all customers who ordered more than 1 quantity of data:
select * from Orders
where quantity>1;

-- 8) Retrieve all orders where the total amount exceeds 20:
 Select *from orders
 where total_amount > 20;
 
 -- 9) Lst all the genres available in Book table:
 Select Distinct genre from Books;

-- 10) Find the book with the lowest stock:
select * from books
order by stock asc limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) as total_revenue
from orders;

-- Advanced Questions:
-- 1) Retrieve the total number of books sold for each genre
select b.Genre, sum(o.Quantity) as total_books_sale
from Orders o
Join Books b on o.book_id=b.book_id
group by b.genre;

-- 2) Find the average price of books in "Fantasy" genre:
select avg(price) as average_price
from books
where genre="fantasy";

-- 3)List the customers who have placed 2 orders:
select Customer_ID, count(order_id) as order_count
from Orders 
Group by Customer_ID
having count(order_id)>=2;

-- 4) Find most frequent ordered book:
select o.book_id, b.title, count(order_id) as order_count
from orders o
join books b on o.book_id=b.book_id
group by o.book_id, b.title
order by order_count desc limit 1;

-- 5) Show the top 3 most expensive book of "Fantasy" genre:
select * from books
where genre="fantasy"
order by price desc limit 3;

-- 6) Retrieve the total amount of book sold by each author:
select b.author, sum(o.total_amount) as total_sale
from orders o
join books b on o.book_id=b.book_id
group by b.author;

-- 7)  List the cities where customers who spent over $30 are located:
select distinct city
from Orders o
Join Customers c on o.customer_id = c.customer_id
where o.total_amount>=30;

-- 8) Find the Customers who spent most on orders:
select c.customer_id, c.name, sum(o.total_amount) as total_spent
from orders o
join customers c on c.customer_id=c.customer_id
group by c.customer_id, c.name
order by total_spent desc limit 1;

-- 9) Calculate the stock remaining after fulfilling all orders:
Select b.book_id, b.title, b.stock, coalesce(sum(quantity),0) as order_quantity,
       b.stock-Coalesce(sum(o.quantity),0) as remaining_quantity
from books b
left join orders o on b.book_id=o.book_id
group by b.book_id
order by b.book_id;