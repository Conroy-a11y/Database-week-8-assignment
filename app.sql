-- =========================================
-- Library Management System Database
-- =========================================

-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;

-- =========================================
-- Step 2: Create Tables
-- =========================================

-- Table: Authors
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    UNIQUE(first_name, last_name)
);

-- Table: Books
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    published_year YEAR,
    publisher VARCHAR(100)
);

-- Many-to-Many relationship: Books <-> Authors
CREATE TABLE BookAuthors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY(book_id, author_id),
    FOREIGN KEY(book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY(author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- Table: Members
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    join_date DATE NOT NULL
);

-- Table: Librarians
CREATE TABLE Librarians (
    librarian_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Table: Loans (One-to-Many: Members -> Loans, Books -> Loans)
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    loan_date DATE NOT NULL,
    return_date DATE,
    due_date DATE NOT NULL,
    FOREIGN KEY(member_id) REFERENCES Members(member_id) ON DELETE CASCADE,
    FOREIGN KEY(book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- Table: Reservations (Optional: Members can reserve books)
CREATE TABLE Reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date DATE NOT NULL,
    status ENUM('Pending','Collected','Cancelled') DEFAULT 'Pending',
    FOREIGN KEY(member_id) REFERENCES Members(member_id) ON DELETE CASCADE,
    FOREIGN KEY(book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    UNIQUE(member_id, book_id)  -- prevent duplicate reservations for the same book by the same member
);

-- =========================================
-- End of LibraryDB Schema
-- =========================================
