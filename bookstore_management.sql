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
