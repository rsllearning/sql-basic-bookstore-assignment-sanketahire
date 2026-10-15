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
