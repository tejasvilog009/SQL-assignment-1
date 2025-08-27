#SQL ASSIGNMENT

-- 1. Create a table called employees with the following structure?
-- : emp_id (integer, should not be NULL and should be a primary key)Q
-- : emp_name (text, should not be NULL)Q
-- : age (integer, should have a check constraint to ensure the age is at least 18)Q
-- : email (text, should be unique for each employee)Q
-- : salary (decimal, with a default value of 30,000).

-- Write the SQL query to create the above table with all constraints.
-- sol.
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY NOT NULL,
    emp_name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18),
    email TEXT UNIQUE,
    salary DECIMAL DEFAULT 30000
);

-- 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
-- examples of common types of constraints.
-- Sol. Constraints are rules applied to database columns to ensure data integrity—keeping data accurate and consistent.

-- Common Types:

-- PRIMARY KEY – Uniquely identifies each row.

-- FOREIGN KEY – Maintains relationships between tables.

-- NOT NULL – Disallows empty values.

-- UNIQUE – Ensures all values are different.

-- CHECK – Validates data based on a condition.

-- DEFAULT – Sets a default value if none is provided.

-- 3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
-- your answer.
-- sol. NOT NULL is used to ensure a column always has a value (no empty fields).

-- A primary key cannot contain NULL because it must uniquely identify each row and NULL means "unknown", which can't ensure uniqueness.

-- By default, primary key columns are NOT NULL.

-- 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
-- example for both adding and removing a constraint.

-- sol. To add or remove constraints on an existing table, you use the ALTER TABLE statement in SQL.
-- to add constraints
ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type (column_name);
-- to remove constraints
ALTER TABLE employees
DROP CONSTRAINT unique_email;

-- 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
-- Provide an example of an error message that might occur when violating a constraint.

-- sol. If you try to insert, update, or delete data that violates a constraint, 
-- the database will reject the operation and return an error message. This protects data accuracy and integrity.
-- Common Consequences:
-- Insert: Fails if required data is missing or invalid.
-- Update: Fails if it causes duplication or breaks relationships.
-- Delete: Fails if it breaks a foreign key relationship.
-- example -1. INSERT INTO employees (id, name) VALUES (1, NULL);
-- 2. INSERT INTO employees (id, email) VALUES (2, 'john@example.com');  -- Duplicate email

-- 6. You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));
    -- Now, you realise that?
-- : The product_id should be a primary keyQ
-- : The price should have a default value of 50.00
    
    -- Add PRIMARY KEY to product_id
-- ALTER TABLE products
-- ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

-- -- Ensure product_name is NOT NULL
-- ALTER TABLE products
-- ALTER COLUMN product_name SET NOT NULL;

-- -- Ensure price is NOT NULL and greater than 0
-- ALTER TABLE products
-- ALTER COLUMN price SET NOT NULL;

-- ALTER TABLE products
-- ADD CONSTRAINT chk_price_positive CHECK (price > 0);
-- Final imprevement 
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0)
);
-- 7. you have two tables:
-- Students:
student_id | student_name | class_id
1             Alice          101
2             Bob            102
3             Charlie        101

-- Class:
 class_id  | Class_name 
  101         Math
  102        Science
  103        
  -- Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

-- sol. To fetch the student_name and class_name for each student using an INNER JOIN, you can use the following SQL query: 
-- SELECT s.student_name, c.class_name
-- FROM Students s
-- INNER JOIN Classes c ON s.class_id = c.class_id;

-- Explanation: 

-- 1. SELECT s.student_name, c.class_name: This specifies the columns you want to retrieve from the joined tables: student_name from the Students table (aliased as s) and class_name from the Classes table (aliased as c). 
-- 2. FROM Students s: This indicates that you are starting the query from the Students table and assigning it the alias s for brevity. 
-- 3. INNER JOIN Classes c ON s.class_id = c.class_id: This performs an INNER JOIN operation with the Classes table (aliased as c). The ON clause specifies the join condition, which is s.class_id = c.class_id. This means that rows from Students and Classes will be combined only when their class_id values match. [1, 2]

-- 8. Consider the following three tables:
-- order:
order_id  | order_date  | customer_id
1           2024-01-01    101
2           2024-01-03    102

-- customers:
customer_id |customer_name
101           Alice
102           bob

-- Products: 
product_id | product_name | order_id
1            laptop        1
2            Phone         NULL

-- Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
-- listed even if they are not associated with an order 

-- The first part of the problem asks to fetch student_name and class_name. However, the provided tables (Orders, Customers, Products) do not contain student_name or class_name columns. Assuming this is a conceptual question and the user meant customer_name instead of student_name, and that class_name is not applicable to the given tables, we will focus on the second part of the question which is directly related to the provided tables. 
-- Problem: Write a query that shows all order_id, customer_name, and product_name, ensuring listed even if they are not associated with an order (Hint: use INNER JOIN and LEFT JOIN). 

-- 1. Join Customers and Orders using INNER JOIN: This will link customer information to their orders based on customer_id. 
-- 2. Join the result with Products using LEFT JOIN: This ensures all orders (and their associated customers) are included, even if a product isn't linked to a specific order (order_id is NULL in Products). 

SELECT
    o.order_id,
    c.customer_name,
    p.product_name
FROM
    Orders AS o
INNER JOIN
    Customers AS c ON o.customer_id = c.customer_id
LEFT JOIN
    Products AS p ON o.order_id = p.order_id;
    

-- 9.Given the following tables:
-- Sales:
 Sale_id  |  product_id  | amount
  1         101            500
  2         102            300
  3         101            700
  
--Products: 
product_id | product_name
101         Laptop
102         Phone
-- Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
--sol.
SELECT
    p.product_name,
    SUM(s.amount) AS total_sales_amount
FROM
    Sales s
INNER JOIN
    Products p ON s.product_id = p.product_id
GROUP BY
    p.product_name;
    
-- 10. You are given three tables:
-- orders: 
  order_id  | order_date  | customer_id
  1           2024-01-02     1
  2           2024-01-05     2
  
  -- customer:
customer_id | customer_name
101           Alice
102           bob

--order_Details:

order_id  | order_date  | Quantity
1            101           2
1            102           1
2            101           3

-- Write a query to display the order_id, customer_name, and the quantity of products ordered by each
-- customer using an INNER JOIN between all three tables.
SELECT
    O.order_id,
    C.customer_name,
    OD.quantity
FROM
    Orders AS O
INNER JOIN
    Customers AS C ON O.customer_id = C.customer_id
INNER JOIN
    Order_Details AS OD ON O.order_id = OD.order_id;


#1- Identify the primary keys and foreign keys in maven movies db. Discuss the differences
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    CONSTRAINT_NAME = 'PRIMARY'
    AND TABLE_SCHEMA = 'mavenmovies';  -- Replace with your actual DB name
    
    SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    REFERENCED_TABLE_NAME IS NOT NULL
    AND TABLE_SCHEMA = 'mavenmovies';  -- Replace with your actual DB name
    
#2. List all details of actors
SELECT * FROM actor;

#3.-List all customer information from DB
SELECT * FROM customer;

#4. -List different countries.
SELECT DISTINCT country FROM country;

#5 Display all active customers 
SELECT * 
FROM customer
WHERE active ;

#6.List of all rental IDs for customer with ID 1.
SELECT rental_id 
FROM rental
WHERE customer_id;

#7. Display all the films whose rental duration is greater than 5 
SELECT * 
FROM film
WHERE rental_duration > 5;

#8.  List the total number of films whose replacement cost is greater than $15 and less than $20
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

#9. - Display the count of unique first names of actors.
SELECT DISTINCT first_name
FROM actor
ORDER BY first_name; -- total 128

#10. Display the first 10 records from the customer table   
SELECT * 
FROM customer
LIMIT 10;

#11. Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT *
FROM customer
WHERE first_name LIKE 'b%'
LIMIT 3;

#12.-Display the names of the first 5 movies which are rated as ‘G’. 
SELECT title
FROM film
WHERE rating = 'G'
LIMIT 5;

#13.Find all customers whose first name starts with "a".
SELECT *
FROM customer
WHERE first_name LIKE 'A%';

#14.  Find all customers whose first name ends with "a".
SELECT *
FROM customer
WHERE first_name LIKE 'A%';

#15. Display the list of first 4 cities which start and end with ‘a’ 
SELECT city
FROM city
WHERE city LIKE 'A%a'
LIMIT 4;

#16.Find all customers whose first name have "NI" in any position.
SELECT *
FROM customer
WHERE first_name LIKE '%NI%';

#17- Find all customers whose first name have "r" in the second position .
SELECT * FROM customer
WHERE first_name LIKE '_r%';

#18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
SELECT * FROM customer
WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

#19- Find all customers whose first name starts with "a" and ends with "o".
SELECT * FROM customer
WHERE first_name LIKE 'a%o';

#20 - Get the films with pg and pg-13 rating using IN operator.
SELECT * FROM film
WHERE rating IN ('PG', 'PG-13');

#21 - Get the films with length between 50 to 100 using between operator.
SELECT * FROM film
WHERE length BETWEEN 50 AND 100;

#22 - Get the top 50 actors using limit operator.
SELECT * FROM actor
LIMIT 50;

#23 - Get the distinct film ids from inventory table.
SELECT DISTINCT film_id
FROM inventory;

-- Question 1:
-- Retrieve the total number of rentals made in the Sakila database.
-- Hint: Use the COUNT() function.
SELECT COUNT(*) AS total_rentals
FROM rental;


-- Question 2:
-- Find the average rental duration (in days) of movies rented from the Sakila database.
-- Hint: Utilize the AVG() function.
SELECT AVG(rental_duration) AS average_rental_duration
FROM film;


-- String Functions:

-- Question 3:
-- Display the first name and last name of customers in uppercase.
-- Hint: Use the UPPER () function.
SELECT UPPER(first_name) AS first_name, UPPER(last_name) AS last_name
FROM customer;


-- Question 4:
-- Extract the month from the rental date and display it alongside the rental ID.
-- Hint: Employ the MONTH() function.
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;


-- GROUP BY:


-- Question 5:
-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
-- Hint: Use COUNT () in conjunction with GROUP BY.
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;


-- Question 6:
-- Find the total revenue generated by each store.
-- Hint: Combine SUM() and GROUP BY.
SELECT staff.store_id, SUM(payment.amount) AS total_revenue
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
GROUP BY staff.store_id;


-- Question 7:
-- Determine the total number of rentals for each category of movies.
-- Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
SELECT category.name AS category, COUNT(*) AS total_rentals
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;


-- Question 8:
-- Find the average rental rate of movies in each language.
-- Hint: JOIN film and language tables, then use AVG () and GROUP BY.
SELECT language.name AS language, AVG(film.rental_rate) AS average_rental_rate
FROM film
JOIN language ON film.language_id = language.language_id
GROUP BY language.name;

--  Questions 9 -
-- Display the title of the movie, customer s first name, and last name who rented it.
-- Hint: Use JOIN between the film, inventory, rental, and customer tables.
SELECT film.title, customer.first_name, customer.last_name
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN customer ON rental.customer_id = customer.customer_id;

-- Question -10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
-- Hint: Use JOIN between the film actor, film, and actor tables.
SELECT actor.first_name, actor.last_name
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.title = 'Gone with the Wind';


-- Question 11:
-- Retrieve the customer names along with the total amount they've spent on rentals.
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total_spent
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;


-- Question 12:List the titles of movies rented by each customer in a particular city (e.g., 'London').
-- Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
SELECT customer.first_name, customer.last_name, film.title
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE city.city = 'London';

-- Question - 13:  Display the top 5 rented movies along with the number of times they've been rented.
-- Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
SELECT 
    f.title AS movie_title,
    COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC
LIMIT 5;


-- Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
-- Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;




#1. Rank the customers based on the total amount they've spent on rentals.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent,
	RANK() OVER (ORDER BY SUM(p.amount) DESC) AS rank
	FROM customer c
	JOIN payment p ON c.customer_id = p.customer_id
	GROUP BY c.customer_id, c.first_name, c.last_name
	ORDER BY total_spent DESC;

#2. Calculate the cumulative revenue generated by each film over time.
SELECT 
    f.film_id,
    f.title,
    p.payment_date,
    SUM(p.amount) AS payment_amount,
    SUM(SUM(p.amount)) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.film_id, f.title, p.payment_date
ORDER BY f.film_id, p.payment_date;

#3. Determine the average rental duration for each film, considering films with similar lengths.
SELECT 
    ROUND(f.length / 30) * 30 AS length_group,  -- e.g., 90, 120, etc.
    AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL
GROUP BY length_group
ORDER BY length_group;

#4. Identify the top 3 films in each category based on their rental counts.
SELECT 
    category_name,
    title,
    rental_count,
    rank
FROM (
    SELECT 
        c.name AS category_name,
        f.title,
        COUNT(r.rental_id) AS rental_count,
        DENSE_RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rank
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name, f.title
) ranked_films
WHERE rank <= 3
ORDER BY category_name, rank;

-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals
-- across all customers.
-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_rentals,
    ROUND(AVG(COUNT(r.rental_id)) OVER (), 2) AS avg_rentals,
    COUNT(r.rental_id) - AVG(COUNT(r.rental_id)) OVER () AS difference_from_avg
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY difference_from_avg DESC;

-- 6. Find the monthly revenue trend for the entire rental store over time
SELECT 
    DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
    SUM(p.amount) AS monthly_revenue
FROM payment p
GROUP BY month
ORDER BY month;

-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers
SELECT 
    customer_id,
    first_name,
    last_name,
    total_spent
FROM (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_spent,
        NTILE(5) OVER (ORDER BY SUM(p.amount) DESC) AS percentile
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
) ranked
WHERE percentile = 1
ORDER BY total_spent DESC;

-- 8. Calculate the running total of rentals per category, ordered by rental count
SELECT 
    category_name,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM (
    SELECT 
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name
) category_rentals
ORDER BY rental_count DESC;

-- 9. Find the films that have been rented less than the average rental count for their respective categories
SELECT 
    category_name,
    title,
    film_rentals,
    avg_category_rentals
FROM (
    SELECT 
        c.name AS category_name,
        f.title,
        COUNT(r.rental_id) AS film_rentals,
        AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.name) AS avg_category_rentals
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name, f.title
) rentals_vs_avg
WHERE film_rentals < avg_category_rentals
ORDER BY category_name, film_rentals;

 
-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month
SELECT 
    month,
    monthly_revenue
FROM (
    SELECT 
        DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
        SUM(p.amount) AS monthly_revenue,
        RANK() OVER (ORDER BY SUM(p.amount) DESC) AS revenue_rank
    FROM payment p
    GROUP BY month
) ranked_months
WHERE revenue_rank <= 5
ORDER BY monthly_revenue DESC;

#1. First Normal Form (1NF):
#a. Identify a table in the Sakila database that violates 1NF. Explain how you
#would normalize it to it to achieve 1NF. 
#Create a junction table to store one special feature per row.

CREATE TABLE film_special_feature (
  film_id SMALLINT NOT NULL,
  feature VARCHAR(50) NOT NULL,
  PRIMARY KEY (film_id, feature),
  FOREIGN KEY (film_id) REFERENCES film(film_id)
);
INSERT INTO film_special_feature (film_id, feature)
VALUES
(1, 'Deleted Scenes'),
(1, 'Behind the Scenes'),
(2, 'Trailers'),
(2, 'Commentaries');

-- Hypothetical table that violates 2NF:
-- Assume we create a rental_summary table with partial dependency

CREATE TABLE rental_summary (
    customer_id INT,
    film_id INT,
    customer_name VARCHAR(100),
    rental_date DATE,
    PRIMARY KEY (customer_id, film_id)
);

-- Violation: customer_name depends only on customer_id (part of the composite key), not on (customer_id, film_id)


-- Table 1: Customer Info
CREATE TABLE customer_info (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

-- Table 2: Rental Info
CREATE TABLE rental_info (
    customer_id INT,
    film_id INT,
    rental_date DATE,
    PRIMARY KEY (customer_id, film_id),
    FOREIGN KEY (customer_id) REFERENCES customer_info(customer_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

-- 3. Third Normal Form (3NF):
--  a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
--  present and outline the steps to normalize the table to 3NF.
 

-- Existing table structure
CREATE TABLE address (
    address_id INT PRIMARY KEY,
    address VARCHAR(100),
    district VARCHAR(50),
    city_id INT,
    postal_code VARCHAR(10),
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

-- Violation: postal_code is transitively dependent on city_id (address_id → city_id → postal_code)

CREATE TABLE city_postal (
    city_id INT PRIMARY KEY,
    postal_code VARCHAR(10),
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

ALTER TABLE address DROP COLUMN postal_code;

SELECT a.address, a.district, c.city, cp.postal_code
FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN city_postal cp ON c.city_id = cp.city_id;

-- 4. Normalization Process:
--  a. Take a specific table in Sakila and guide through the process of normalizing it from the initial 
--  unnormalized form
-- UNF: Unnormalized customer orders (hypothetical example)
CREATE TABLE customer_orders_unf (
    order_id INT,
    customer_name VARCHAR(100),
    products_ordered VARCHAR(255)  -- 'Film A, Film B, Film C'
);

-- 1NF: Make values atomic by separating products into rows
CREATE TABLE customer_orders_1nf (
    order_id INT,
    customer_name VARCHAR(100),
    product_name VARCHAR(100)
);

-- 2NF: Remove partial dependency (customer_name depends only on order_id)
-- Step 1: Create customer table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

-- Step 2: Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Step 3: Create order_items table
CREATE TABLE order_items (
    order_id INT,
    product_name VARCHAR(100),
    PRIMARY KEY (order_id, product_name),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 5. CTE Basics:
-- a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
-- have acted in from the actor and film_actor tables.

WITH actor_film_count AS (
    SELECT
        fa.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM film_actor fa
    JOIN actor a ON fa.actor_id = a.actor_id
    GROUP BY fa.actor_id, a.first_name, a.last_name
)
SELECT DISTINCT actor_name, film_count
FROM actor_film_count
ORDER BY film_count DESC;

-- 6. CTE with Joins:
--  a. Create a CTE that combines information from the film and language tables to display the film title, 
--  language name, 
WITH film_language_info AS (
    SELECT
        f.film_id,
        f.title,
        l.name AS language_name
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT title, language_name
FROM film_language_info
ORDER BY title;



-- 7. CTE for Aggregation:
--  a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
--  from the customer and payment tab
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT customer_name, total_revenue
FROM customer_revenue
ORDER BY total_revenue DESC;

-- 7. CTE for Aggregation:
--  a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
--  from the customer and payment tab

WITH CustomerPayments AS (
    SELECT
        customer_id,
        SUM(amount) AS total_revenue
    FROM payment
    GROUP BY customer_id
)

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    cp.total_revenue
FROM customer c
JOIN CustomerPayments cp ON c.customer_id = cp.customer_id
ORDER BY cp.total_revenue DESC;


-- 8.CTE with Window Functions:
-- a. Utilize a CTE with a window function to rank films based on their rental duration from the film table
WITH FilmRanks AS (
    SELECT
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_rank
    FROM film
)

SELECT *
FROM FilmRanks
ORDER BY rental_rank;

-- 9. CTE and Filtering:
--  a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
--  customer table to retrieve additional customer details
WITH FrequentRenters AS (
    SELECT
        customer_id,
        COUNT(rental_id) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 2
)

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    fr.rental_count
FROM customer c
JOIN FrequentRenters fr ON c.customer_id = fr.customer_id
ORDER BY fr.rental_count DESC;

-- 10.CTE for Date Calculations:
--  a. Write a query using a CTE to find the total number of rentals made each month, considering the 
--  rental_date from the rental table
WITH MonthlyRentals AS (
    SELECT
        DATE_TRUNC('month', rental_date) AS rental_month,
        COUNT(*) AS total_rentals
    FROM rental
    GROUP BY DATE_TRUNC('month', rental_date)
)

SELECT *
FROM MonthlyRentals
ORDER BY rental_month;

-- 11. CTE and Self-Join:
--  a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
--  together, using the film_actor tab
WITH ActorFilms AS (
    SELECT
        film_id,
        actor_id
    FROM film_actor
)

SELECT
    af1.actor_id AS actor1_id,
    af2.actor_id AS actor2_id,
    af1.film_id
FROM ActorFilms af1
JOIN ActorFilms af2
    ON af1.film_id = af2.film_id
    AND af1.actor_id < af2.actor_id
ORDER BY af1.film_id, af1.actor_id, af2.actor_id;

-- 12. CTE for Recursive Search:
--  a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 
--  considering the rep
WITH RECURSIVE StaffHierarchy AS (
    SELECT
        staff_id,
        first_name,
        last_name,
        manager_id
    FROM staff
    WHERE manager_id = 1  -- Replace with the specific manager's ID

    UNION ALL

    SELECT
        s.staff_id,
        s.first_name,
        s.last_name,
        s.manager_id
    FROM staff s
    JOIN StaffHierarchy sh ON s.manager_id = sh.staff_id
)

SELECT *
FROM StaffHierarchy;
































