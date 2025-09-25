# Database-week-8-assignment

# Library Management Database

This project defines a relational database schema for a **Library Management System**.  
It supports managing books, authors, members, librarians, loans, and reservations.

---

## 📑 Database Schema Overview

### 1. **Authors**

Stores information about book authors.

- `author_id` (PK) – Unique identifier for each author
- `first_name` – Author’s first name
- `last_name` – Author’s last name
- **Constraint:** Combination of `first_name` and `last_name` must be unique

---

### 2. **Books**

Stores information about books.

- `book_id` (PK) – Unique identifier for each book
- `title` – Book title
- `isbn` – Unique ISBN number
- `published_year` – Year of publication
- `publisher` – Publisher name

---

### 3. **BookAuthors**

Associative table to model the **many-to-many relationship** between **Books** and **Authors**.

- `book_id` (FK → Books.book_id)
- `author_id` (FK → Authors.author_id)
- **Primary Key:** (`book_id`, `author_id`)
- **Cascade Delete:** If a book or author is deleted, related records are removed automatically

---

### 4. **Members**

Stores details of library members.

- `member_id` (PK) – Unique identifier
- `first_name` – Member’s first name
- `last_name` – Member’s last name
- `email` – Unique email address
- `phone` – Contact number
- `join_date` – Date the member joined

---

### 5. **Librarians**

Stores librarian details.

- `librarian_id` (PK) – Unique identifier
- `first_name` – Librarian’s first name
- `last_name` – Librarian’s last name
- `email` – Unique email address

---

### 6. **Loans**

Tracks book borrowings (**One-to-Many: Members → Loans, Books → Loans**).

- `loan_id` (PK) – Unique identifier for each loan
- `member_id` (FK → Members.member_id)
- `book_id` (FK → Books.book_id)
- `loan_date` – Date the book was borrowed
- `due_date` – Due date for return
- `return_date` – Actual return date (nullable)
- **Cascade Delete:** If member/book is deleted, their loans are removed

---

### 7. **Reservations**

Tracks book reservations by members.

- `reservation_id` (PK) – Unique identifier
- `member_id` (FK → Members.member_id)
- `book_id` (FK → Books.book_id)
- `reservation_date` – Date of reservation
- `status` – Reservation status (default: `Pending`)
- **Constraint:** (`member_id`, `book_id`) must be unique to prevent duplicate reservations

---

## 🔑 Relationships

- **Books ↔ Authors**: Many-to-Many via `BookAuthors`
- **Members → Loans**: One-to-Many
- **Books → Loans**: One-to-Many
- **Members → Reservations**: One-to-Many
- **Books → Reservations**: One-to-Many

---

## ⚙️ Features

- Ensures **data integrity** with primary keys, foreign keys, and unique constraints.
- Supports **cascading deletes** for dependent records.
- Prevents duplicate reservations for the same book by the same member.

---

## 🚀 Usage

1. Run the SQL script in a **SQL Server** (or compatible RDBMS).
2. Use `INSERT`, `SELECT`, `UPDATE`, and `DELETE` queries to manage:
   - Authors & Books
   - Members & Librarians
   - Loans & Reservations

---

## 📌 Example Query

Get all books reserved by a specific member:

```sql
SELECT b.title, r.reservation_date, r.status
FROM Reservations r
JOIN Books b ON r.book_id = b.book_id
WHERE r.member_id = 1;

```
