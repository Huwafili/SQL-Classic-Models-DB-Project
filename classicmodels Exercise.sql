use classicmodels;

/* Explore the tables and columns */
Select *
From customers;

/**********
  Basics Exercises
**********/

#1) Write down sql query to show different countries from customers table
select distinct(country)
from customers
Order By country Asc;

#2) write a query to show number of cities in customers table
select Count(Distinct city) As NumberofCities
from customers;

#3) How many of my customers are from London in customers table?
SELECT COUNT(*) AS customers_from_London
FROM customers
WHERE city = 'London';

#4)How many of customers from UK but not from London?
SELECT COUNT(*) AS customers_from_UK_not_London
FROM customers
WHERE country = 'UK' AND city != 'london';

#5)Write SQL query to show number of Sales Rep in employees table
SELECT Count(*) AS Number_of_Sales_Rep 
FROM employees
WHERE jobTitle = 'sales rep';

#6) What is the address line2 for the office in San Francisco in offices table?
SELECT addressLine1, addressLine2, state, country, postalCode
FROM offices
WHERE city = 'San Francisco';

#7) What is the largest quantity ordered in orderdetails table?
SELECT MAX(quantityOrdered) AS largest_quantity_ordered
FROM orderdetails;

#8) Whats the highest amount paid on '2003-09-28' in payments table?
SELECT Max(amount) As Highest_Amount_Paid
FROM payments
WHERE paymentDate = '2003-09-28';

#9) Which products are avaliable more than 5000 in stock and also has buyprice lower than 25?
SELECT productName, quantityInStock, buyPrice
FROM products
WHERE quantityInStock > 5000 AND buyPrice < 25;

#10) select customers who do not have a credit limit (0.00). 
SELECT customerNumber, customerName, creditLimit
FROM customers
WHERE creditLimit > 0.00;

#11)  Ask your own question and write a query to answer. Share and discuss with your friends.
SELECT productName, productLine, buyPrice
FROM products
ORDER BY buyPrice DESC
LIMIT 5;

#12) Ask your own question and write a query to answer. Share and discuss with your friends.
SELECT customerName, customerNumber
FROM customers
WHERE customerNumber NOT IN (SELECT customerNumber FROM orders);


#13) Ask your own question and write a query to answer. Share and discuss with your friends.
SELECT customerNumber, customerName, phone, addressLine1, city, state, postalCode, country
FROM customers
Where customerName Like 'A%'
order by state Desc
Limit 5;

-- Which customers have never placed an order?
SELECT customerName, customerNumber
FROM customers
WHERE customerNumber NOT IN (SELECT customerNumber FROM orders);



/********** 
Joins and group by Exercises 
**********/


/* 1- Find office information of each employee with their first, lastname, addressLine1, state and their city */
SELECT firstName, lastName, addressLine1, state, city
FROM offices
JOIN employees
ON offices.officeCode = employees.officeCode;

/* 2- How many orders have been placed by Herkku Gifts? */
SELECT COUNT(O.orderNumber) AS total_orders
FROM customers As C
JOIN orders As O 
ON C.customerNumber = O.customerNumber
WHERE C.customerName = 'Herkku Gifts';


/* 3- Write sql query to find total payments for Atelier graphique */
SELECT SUM(P.amount) AS Total_Payment
FROM customers As C
JOIN payments As P 
ON C.customerNumber = P.customerNumber
WHERE C.customerName = 'Atelier graphique';

/* 4- Write sql query find the total payments by date */
SELECT paymentDate, SUM(amount) AS total_payments
FROM payments AS P
GROUP BY P.paymentDate
ORDER BY P.paymentDate;

/* 5- Write a query to find the amount paid by each customer. */
SELECT customerName, SUM(amount) AS Total_Paid
FROM customers
JOIN payments 
ON customers.customerNumber = payments.customerNumber
GROUP BY customers.customerNumber
ORDER BY total_paid DESC;


/* 6- Write sql to find top 10 customers the highest total amount paid */
SELECT customerName, SUM(amount) AS Total_Paid
FROM customers
JOIN payments 
ON customers.customerNumber = payments.customerNumber
GROUP BY customers.customerNumber
ORDER BY total_paid DESC
Limit 10;

/* 7- Write a query to find the account representative for each customer.*/
SELECT customerName, contactFirstName As Account_Representative, contactLastName As Account_Representative
FROM customers
LEFT JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber;


/* 8- Write sql query to find the employees who live in Boston */
SELECT employeeNumber, lastName, firstName, city
FROM employees
JOIN offices
ON offices.officeCode = employees.officeCode
WHERE city = 'Boston';



