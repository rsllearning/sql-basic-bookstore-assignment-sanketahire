-- ========================================================
-- Assignment: SQL (Basic) - Online Bookstore Management
-- Author: Sanket Ahire
-- Organization: Raja Software Labs
-- Target RDBMS: MySQL 8.x
-- File: bookstore_management.sql
-- ========================================================

-- Ensure clean, reproducible environment (Idempotent Execution)
DROP DATABASE IF EXISTS bookstore_db;
CREATE DATABASE bookstore_db;
USE bookstore_db;

-- ========================================================
-- Schema Definition (DDL)
-- ========================================================

-- Table 1: Authors
CREATE TABLE Authors (
    author_id   INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    country     VARCHAR(50) NOT NULL
);

-- Table 2: Books
CREATE TABLE Books (
    book_id        INT PRIMARY KEY,
    title          VARCHAR(100) NOT NULL,
    author_id      INT,
    category       VARCHAR(50) NOT NULL,
    price          DECIMAL(10,2) NOT NULL,
    published_year INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- ========================================================
-- Sample Seed Data (DML)
-- ========================================================

-- Seed Authors (7 Authors across 7 countries; Author 7 intentionally has 0 books for outer join validation)
INSERT INTO Authors (author_id, author_name, country) VALUES
(1, 'Robert C. Martin', 'USA'),
(2, 'Martin Kleppmann', 'UK'),
(3, 'Haruki Murakami', 'Japan'),
(4, 'Yuval Noah Harari', 'Israel'),
(5, 'Amartya Sen', 'India'),
(6, 'Klaus Schwab', 'Germany'),
(7, 'Margaret Atwood', 'Canada');

-- Seed Books (14 Books across 5 distinct categories)
INSERT INTO Books (book_id, title, author_id, category, price, published_year) VALUES
(101, 'System Design Fundamentals', 2, 'Programming', 850.00, 2021),
(102, 'SQL Essentials and Internals', 1, 'Programming', 750.00, 2022),
(103, 'Clean Architecture Principles', 1, 'Programming', 620.00, 2019),
(104, 'Designing Data-Intensive Applications', 2, 'Data Science', 920.00, 2017),
(105, 'Statistical Learning & AI', 2, 'Data Science', 680.00, 2023),
(106, 'Big Data Analytics Mastery', 6, 'Data Science', 780.00, 2022),
(107, 'Norwegian Wood', 3, 'Fiction', 450.00, 2018),
(108, 'Kafka on the Shore', 3, 'Fiction', 550.00, 2020),
(109, 'South of the Border', 3, 'Fiction', 420.00, 2021),
(110, 'Sapiens: A Brief History of Humankind', 4, 'History', 520.00, 2018),
(111, 'Homo Deus: A Brief History of Tomorrow', 4, 'History', 480.00, 2019),
(112, 'The Structure of World History', 6, 'History', 560.00, 2024),
(113, 'Development as Freedom', 5, 'Business', 580.00, 2019),
(114, 'Scale: Universal Laws of Growth', 6, 'Business', 640.00, 2021);


-- ========================================================
-- Section 1: Basic Queries
-- ========================================================

-- Task 1: Display all books.
SELECT * FROM Books;
/*
Expected Output:
+---------+----------------------------------------+-----------+--------------+--------+----------------+
| book_id | title                                  | author_id | category     | price  | published_year |
+---------+----------------------------------------+-----------+--------------+--------+----------------+
|     101 | System Design Fundamentals             |         2 | Programming  | 850.00 |           2021 |
|     102 | SQL Essentials and Internals           |         1 | Programming  | 750.00 |           2022 |
|     103 | Clean Architecture Principles          |         1 | Programming  | 620.00 |           2019 |
|     104 | Designing Data-Intensive Applications  |         2 | Data Science | 920.00 |           2017 |
|     105 | Statistical Learning & AI              |         2 | Data Science | 680.00 |           2023 |
|     106 | Big Data Analytics Mastery             |         6 | Data Science | 780.00 |           2022 |
|     107 | Norwegian Wood                         |         3 | Fiction      | 450.00 |           2018 |
|     108 | Kafka on the Shore                     |         3 | Fiction      | 550.00 |           2020 |
|     109 | South of the Border                    |         3 | Fiction      | 420.00 |           2021 |
|     110 | Sapiens: A Brief History of Humankind  |         4 | History      | 520.00 |           2018 |
|     111 | Homo Deus: A Brief History of Tomorrow |         4 | History      | 480.00 |           2019 |
|     112 | The Structure of World History         |         6 | History      | 560.00 |           2024 |
|     113 | Development as Freedom                 |         5 | Business     | 580.00 |           2019 |
|     114 | Scale: Universal Laws of Growth        |         6 | Business     | 640.00 |           2021 |
+---------+----------------------------------------+-----------+--------------+--------+----------------+
14 rows in set
*/

-- Task 2: Display only the book title and price.
SELECT title, price 
FROM Books;
/*
Expected Output:
+----------------------------------------+--------+
| title                                  | price  |
+----------------------------------------+--------+
| System Design Fundamentals             | 850.00 |
| SQL Essentials and Internals           | 750.00 |
| Clean Architecture Principles          | 620.00 |
| Designing Data-Intensive Applications  | 920.00 |
| Statistical Learning & AI              | 680.00 |
| Big Data Analytics Mastery             | 780.00 |
| Norwegian Wood                         | 450.00 |
| Kafka on the Shore                     | 550.00 |
| South of the Border                    | 420.00 |
| Sapiens: A Brief History of Humankind  | 520.00 |
| Homo Deus: A Brief History of Tomorrow | 480.00 |
| The Structure of World History         | 560.00 |
| Development as Freedom                 | 580.00 |
| Scale: Universal Laws of Growth        | 640.00 |
+----------------------------------------+--------+
14 rows in set
*/

-- Task 3: Display the book title as Book Name and price as Book Price using column aliases.
SELECT title AS `Book Name`, price AS `Book Price` 
FROM Books;
/*
Expected Output:
+----------------------------------------+------------+
| Book Name                              | Book Price |
+----------------------------------------+------------+
| System Design Fundamentals             |     850.00 |
| SQL Essentials and Internals           |     750.00 |
| Clean Architecture Principles          |     620.00 |
| Designing Data-Intensive Applications  |     920.00 |
| Statistical Learning & AI              |     680.00 |
| Big Data Analytics Mastery             |     780.00 |
| Norwegian Wood                         |     450.00 |
| Kafka on the Shore                     |     550.00 |
| South of the Border                    |     420.00 |
| Sapiens: A Brief History of Humankind  |     520.00 |
| Homo Deus: A Brief History of Tomorrow |     480.00 |
| The Structure of World History         |     560.00 |
| Development as Freedom                 |     580.00 |
| Scale: Universal Laws of Growth        |     640.00 |
+----------------------------------------+------------+
14 rows in set
*/

-- Task 4: Display all unique book categories.
SELECT DISTINCT category 
FROM Books;
/*
Expected Output:
+--------------+
| category     |
+--------------+
| Programming  |
| Data Science |
| Fiction      |
| History      |
| Business     |
+--------------+
5 rows in set
*/


-- ========================================================
-- Section 2: Filtering Data
-- ========================================================

-- Task 5: Display books priced above ₹700.
SELECT * 
FROM Books 
WHERE price > 700;
/*
Expected Output:
+---------+---------------------------------------+-----------+--------------+--------+----------------+
| book_id | title                                 | author_id | category     | price  | published_year |
+---------+---------------------------------------+-----------+--------------+--------+----------------+
|     101 | System Design Fundamentals            |         2 | Programming  | 850.00 |           2021 |
|     102 | SQL Essentials and Internals          |         1 | Programming  | 750.00 |           2022 |
|     104 | Designing Data-Intensive Applications |         2 | Data Science | 920.00 |           2017 |
|     106 | Big Data Analytics Mastery            |         6 | Data Science | 780.00 |           2022 |
+---------+---------------------------------------+-----------+--------------+--------+----------------+
4 rows in set
*/

-- Task 6: Display books priced between ₹500 and ₹800.
SELECT * 
FROM Books 
WHERE price BETWEEN 500 AND 800;
/*
Expected Output:
+---------+---------------------------------------+-----------+--------------+--------+----------------+
| book_id | title                                 | author_id | category     | price  | published_year |
+---------+---------------------------------------+-----------+--------------+--------+----------------+
|     102 | SQL Essentials and Internals          |         1 | Programming  | 750.00 |           2022 |
|     103 | Clean Architecture Principles         |         1 | Programming  | 620.00 |           2019 |
|     105 | Statistical Learning & AI             |         2 | Data Science | 680.00 |           2023 |
|     106 | Big Data Analytics Mastery            |         6 | Data Science | 780.00 |           2022 |
|     108 | Kafka on the Shore                    |         3 | Fiction      | 550.00 |           2020 |
|     110 | Sapiens: A Brief History of Humankind |         4 | History      | 520.00 |           2018 |
|     112 | The Structure of World History        |         6 | History      | 560.00 |           2024 |
|     113 | Development as Freedom                |         5 | Business     | 580.00 |           2019 |
|     114 | Scale: Universal Laws of Growth       |         6 | Business     | 640.00 |           2021 |
+---------+---------------------------------------+-----------+--------------+--------+----------------+
9 rows in set
*/

-- Task 7: Display books that belong to the Programming category.
SELECT * 
FROM Books 
WHERE category = 'Programming';
/*
Expected Output:
+---------+-------------------------------+-----------+-------------+--------+----------------+
| book_id | title                         | author_id | category    | price  | published_year |
+---------+-------------------------------+-----------+-------------+--------+----------------+
|     101 | System Design Fundamentals    |         2 | Programming | 850.00 |           2021 |
|     102 | SQL Essentials and Internals  |         1 | Programming | 750.00 |           2022 |
|     103 | Clean Architecture Principles |         1 | Programming | 620.00 |           2019 |
+---------+-------------------------------+-----------+-------------+--------+----------------+
3 rows in set
*/

-- Task 8: Display books whose titles start with the letter S.
SELECT * 
FROM Books 
WHERE title LIKE 'S%';
/*
Expected Output:
+---------+---------------------------------------+-----------+--------------+--------+----------------+
| book_id | title                                 | author_id | category     | price  | published_year |
+---------+---------------------------------------+-----------+--------------+--------+----------------+
|     101 | System Design Fundamentals            |         2 | Programming  | 850.00 |           2021 |
|     102 | SQL Essentials and Internals          |         1 | Programming  | 750.00 |           2022 |
|     105 | Statistical Learning & AI             |         2 | Data Science | 680.00 |           2023 |
|     109 | South of the Border                   |         3 | Fiction      | 420.00 |           2021 |
|     110 | Sapiens: A Brief History of Humankind |         4 | History      | 520.00 |           2018 |
|     114 | Scale: Universal Laws of Growth       |         6 | Business     | 640.00 |           2021 |
+---------+---------------------------------------+-----------+--------------+--------+----------------+
6 rows in set
*/

-- Task 9: Display books published after 2020.
SELECT * 
FROM Books 
WHERE published_year > 2020;
/*
Expected Output:
+---------+---------------------------------+-----------+--------------+--------+----------------+
| book_id | title                           | author_id | category     | price  | published_year |
+---------+---------------------------------+-----------+--------------+--------+----------------+
|     101 | System Design Fundamentals      |         2 | Programming  | 850.00 |           2021 |
|     102 | SQL Essentials and Internals    |         1 | Programming  | 750.00 |           2022 |
|     105 | Statistical Learning & AI       |         2 | Data Science | 680.00 |           2023 |
|     106 | Big Data Analytics Mastery      |         6 | Data Science | 780.00 |           2022 |
|     109 | South of the Border             |         3 | Fiction      | 420.00 |           2021 |
|     112 | The Structure of World History  |         6 | History      | 560.00 |           2024 |
|     114 | Scale: Universal Laws of Growth |         6 | Business     | 640.00 |           2021 |
+---------+---------------------------------+-----------+--------------+--------+----------------+
7 rows in set
*/


-- ========================================================
-- Section 3: Sorting and Limiting Results
-- ========================================================

-- Task 10: Display books sorted by price in descending order.
SELECT * 
FROM Books 
ORDER BY price DESC;
/*
Expected Output:
+---------+----------------------------------------+-----------+--------------+--------+----------------+
| book_id | title                                  | author_id | category     | price  | published_year |
+---------+----------------------------------------+-----------+--------------+--------+----------------+
|     104 | Designing Data-Intensive Applications  |         2 | Data Science | 920.00 |           2017 |
|     101 | System Design Fundamentals             |         2 | Programming  | 850.00 |           2021 |
|     106 | Big Data Analytics Mastery             |         6 | Data Science | 780.00 |           2022 |
|     102 | SQL Essentials and Internals           |         1 | Programming  | 750.00 |           2022 |
|     105 | Statistical Learning & AI              |         2 | Data Science | 680.00 |           2023 |
|     114 | Scale: Universal Laws of Growth        |         6 | Business     | 640.00 |           2021 |
|     103 | Clean Architecture Principles          |         1 | Programming  | 620.00 |           2019 |
|     113 | Development as Freedom                 |         5 | Business     | 580.00 |           2019 |
|     112 | The Structure of World History         |         6 | History      | 560.00 |           2024 |
|     108 | Kafka on the Shore                     |         3 | Fiction      | 550.00 |           2020 |
|     110 | Sapiens: A Brief History of Humankind  |         4 | History      | 520.00 |           2018 |
|     111 | Homo Deus: A Brief History of Tomorrow |         4 | History      | 480.00 |           2019 |
|     107 | Norwegian Wood                         |         3 | Fiction      | 450.00 |           2018 |
|     109 | South of the Border                    |         3 | Fiction      | 420.00 |           2021 |
+---------+----------------------------------------+-----------+--------------+--------+----------------+
14 rows in set
*/

-- Task 11: Display the top 3 most expensive books.
SELECT * 
FROM Books 
ORDER BY price DESC 
LIMIT 3;
/*
Expected Output:
+---------+---------------------------------------+-----------+--------------+--------+----------------+
| book_id | title                                 | author_id | category     | price  | published_year |
+---------+---------------------------------------+-----------+--------------+--------+----------------+
|     104 | Designing Data-Intensive Applications |         2 | Data Science | 920.00 |           2017 |
|     101 | System Design Fundamentals            |         2 | Programming  | 850.00 |           2021 |
|     106 | Big Data Analytics Mastery            |         6 | Data Science | 780.00 |           2022 |
+---------+---------------------------------------+-----------+--------------+--------+----------------+
3 rows in set
*/


-- ========================================================
-- Section 4: Aggregate Functions
-- ========================================================

-- Task 12: Find total number of books, total price, average price, highest price, and lowest price.
SELECT 
    COUNT(*)                AS `Total Books`,
    SUM(price)              AS `Total Price`,
    ROUND(AVG(price), 2)    AS `Average Price`,
    MAX(price)              AS `Highest Price`,
    MIN(price)              AS `Lowest Price`
FROM Books;
/*
Expected Output:
+-------------+-------------+---------------+---------------+--------------+
| Total Books | Total Price | Average Price | Highest Price | Lowest Price |
+-------------+-------------+---------------+---------------+--------------+
|          14 |     8800.00 |        628.57 |        920.00 |       420.00 |
+-------------+-------------+---------------+---------------+--------------+
1 row in set
*/


-- ========================================================
-- Section 5: GROUP BY and HAVING
-- ========================================================

-- Task 13: Display the average book price for each category.
SELECT 
    category, 
    ROUND(AVG(price), 2) AS `Average Price`
FROM Books
GROUP BY category;
/*
Expected Output:
+--------------+---------------+
| category     | Average Price |
+--------------+---------------+
| Programming  |        740.00 |
| Data Science |        793.33 |
| Fiction      |        473.33 |
| History      |        520.00 |
| Business     |        610.00 |
+--------------+---------------+
5 rows in set
*/

-- Task 14: Display only those categories whose average book price is greater than ₹650.
SELECT 
    category, 
    ROUND(AVG(price), 2) AS `Average Price`
FROM Books
GROUP BY category
HAVING AVG(price) > 650;
/*
Expected Output:
+--------------+---------------+
| category     | Average Price |
+--------------+---------------+
| Programming  |        740.00 |
| Data Science |        793.33 |
+--------------+---------------+
2 rows in set
*/


-- ========================================================
-- Section 6: Joins
-- ========================================================

-- Task 15: Display each book along with its author's name using an INNER JOIN.
SELECT 
    b.book_id,
    b.title,
    a.author_name,
    b.category,
    b.price
FROM Books b
INNER JOIN Authors a 
    ON b.author_id = a.author_id;
/*
Expected Output:
+---------+----------------------------------------+-------------------+--------------+--------+
| book_id | title                                  | author_name       | category     | price  |
+---------+----------------------------------------+-------------------+--------------+--------+
|     102 | SQL Essentials and Internals           | Robert C. Martin  | Programming  | 750.00 |
|     103 | Clean Architecture Principles          | Robert C. Martin  | Programming  | 620.00 |
|     101 | System Design Fundamentals             | Martin Kleppmann  | Programming  | 850.00 |
|     104 | Designing Data-Intensive Applications  | Martin Kleppmann  | Data Science | 920.00 |
|     105 | Statistical Learning & AI              | Martin Kleppmann  | Data Science | 680.00 |
|     107 | Norwegian Wood                         | Haruki Murakami   | Fiction      | 450.00 |
|     108 | Kafka on the Shore                     | Haruki Murakami   | Fiction      | 550.00 |
|     109 | South of the Border                    | Haruki Murakami   | Fiction      | 420.00 |
|     110 | Sapiens: A Brief History of Humankind  | Yuval Noah Harari | History      | 520.00 |
|     111 | Homo Deus: A Brief History of Tomorrow | Yuval Noah Harari | History      | 480.00 |
|     113 | Development as Freedom                 | Amartya Sen       | Business     | 580.00 |
|     106 | Big Data Analytics Mastery             | Klaus Schwab      | Data Science | 780.00 |
|     112 | The Structure of World History         | Klaus Schwab      | History      | 560.00 |
|     114 | Scale: Universal Laws of Growth        | Klaus Schwab      | Business     | 640.00 |
+---------+----------------------------------------+-------------------+--------------+--------+
14 rows in set
*/

-- Task 16: Display all authors along with the books they have written using a LEFT JOIN.
SELECT 
    a.author_id,
    a.author_name,
    a.country,
    b.title,
    b.price
FROM Authors a
LEFT JOIN Books b 
    ON a.author_id = b.author_id;
/*
Expected Output:
+-----------+-------------------+---------+----------------------------------------+--------+
| author_id | author_name       | country | title                                  | price  |
+-----------+-------------------+---------+----------------------------------------+--------+
|         1 | Robert C. Martin  | USA     | SQL Essentials and Internals           | 750.00 |
|         1 | Robert C. Martin  | USA     | Clean Architecture Principles          | 620.00 |
|         2 | Martin Kleppmann  | UK      | System Design Fundamentals             | 850.00 |
|         2 | Martin Kleppmann  | UK      | Designing Data-Intensive Applications  | 920.00 |
|         2 | Martin Kleppmann  | UK      | Statistical Learning & AI              | 680.00 |
|         3 | Haruki Murakami   | Japan   | Norwegian Wood                         | 450.00 |
|         3 | Haruki Murakami   | Japan   | Kafka on the Shore                     | 550.00 |
|         3 | Haruki Murakami   | Japan   | South of the Border                    | 420.00 |
|         4 | Yuval Noah Harari | Israel  | Sapiens: A Brief History of Humankind  | 520.00 |
|         4 | Yuval Noah Harari | Israel  | Homo Deus: A Brief History of Tomorrow | 480.00 |
|         5 | Amartya Sen       | India   | Development as Freedom                 | 580.00 |
|         6 | Klaus Schwab      | Germany | Big Data Analytics Mastery             | 780.00 |
|         6 | Klaus Schwab      | Germany | The Structure of World History         | 560.00 |
|         6 | Klaus Schwab      | Germany | Scale: Universal Laws of Growth        | 640.00 |
|         7 | Margaret Atwood   | Canada  | NULL                                   |   NULL |
+-----------+-------------------+---------+----------------------------------------+--------+
15 rows in set
*/

-- Task 17: Display all books along with their author details using a RIGHT JOIN.
SELECT 
    b.book_id,
    b.title,
    a.author_name,
    a.country,
    b.price
FROM Authors a
RIGHT JOIN Books b 
    ON a.author_id = b.author_id;
/*
Expected Output:
+---------+----------------------------------------+-------------------+---------+--------+
| book_id | title                                  | author_name       | country | price  |
+---------+----------------------------------------+-------------------+---------+--------+
|     101 | System Design Fundamentals             | Martin Kleppmann  | UK      | 850.00 |
|     102 | SQL Essentials and Internals           | Robert C. Martin  | USA     | 750.00 |
|     103 | Clean Architecture Principles          | Robert C. Martin  | USA     | 620.00 |
|     104 | Designing Data-Intensive Applications  | Martin Kleppmann  | UK      | 920.00 |
|     105 | Statistical Learning & AI              | Martin Kleppmann  | UK      | 680.00 |
|     106 | Big Data Analytics Mastery             | Klaus Schwab      | Germany | 780.00 |
|     107 | Norwegian Wood                         | Haruki Murakami   | Japan   | 450.00 |
|     108 | Kafka on the Shore                     | Haruki Murakami   | Japan   | 550.00 |
|     109 | South of the Border                    | Haruki Murakami   | Japan   | 420.00 |
|     110 | Sapiens: A Brief History of Humankind  | Yuval Noah Harari | Israel  | 520.00 |
|     111 | Homo Deus: A Brief History of Tomorrow | Yuval Noah Harari | Israel  | 480.00 |
|     112 | The Structure of World History         | Klaus Schwab      | Germany | 560.00 |
|     113 | Development as Freedom                 | Amartya Sen       | India   | 580.00 |
|     114 | Scale: Universal Laws of Growth        | Klaus Schwab      | Germany | 640.00 |
+---------+----------------------------------------+-------------------+---------+--------+
14 rows in set
*/


-- ========================================================
-- Section 7: Data Manipulation
-- ========================================================

-- Task 18: Insert a new book into the Books table.
INSERT INTO Books (book_id, title, author_id, category, price, published_year) 
VALUES (115, 'Database Internals & Storage Engines', 2, 'Programming', 720.00, 2023);

-- Verification for Task 18: Confirm row insertion
SELECT * 
FROM Books 
WHERE book_id = 115;
/*
Expected Output:
+---------+--------------------------------------+-----------+-------------+--------+----------------+
| book_id | title                                | author_id | category    | price  | published_year |
+---------+--------------------------------------+-----------+-------------+--------+----------------+
|     115 | Database Internals & Storage Engines |         2 | Programming | 720.00 |           2023 |
+---------+--------------------------------------+-----------+-------------+--------+----------------+
1 row in set
*/

-- Task 19: Update the price of the book you inserted.
UPDATE Books 
SET price = 799.00 
WHERE book_id = 115;

-- Verification for Task 19: Confirm price update
SELECT * 
FROM Books 
WHERE book_id = 115;
/*
Expected Output:
+---------+--------------------------------------+-----------+-------------+--------+----------------+
| book_id | title                                | author_id | category    | price  | published_year |
+---------+--------------------------------------+-----------+-------------+--------+----------------+
|     115 | Database Internals & Storage Engines |         2 | Programming | 799.00 |           2023 |
+---------+--------------------------------------+-----------+-------------+--------+----------------+
1 row in set
*/

-- Task 20: Delete the book record that you inserted.
DELETE FROM Books 
WHERE book_id = 115;

-- Verification for Task 20: Confirm record removal
SELECT * 
FROM Books 
WHERE book_id = 115;
/*
Expected Output:
Empty set (0 rows returned)
*/
