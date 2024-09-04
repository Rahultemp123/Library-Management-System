
-- Library Management System SQL Script

-- Create Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    genre VARCHAR(100),
    published_year YEAR,
    available_copies INT
);

-- Create Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(15),
    membership_date DATE
);

-- Create Transactions Table
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    issue_date DATE,
    return_date DATE,
    status ENUM('Issued', 'Returned'),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert Sample Data into Books Table
INSERT INTO Books (title, author, genre, published_year, available_copies)
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, 5),
('1984', 'George Orwell', 'Dystopian', 1949, 3),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 4);

-- Insert Sample Data into Users Table
INSERT INTO Users (name, email, phone_number, membership_date)
VALUES 
('John Doe', 'john@example.com', '1234567890', CURDATE()),
('Jane Smith', 'jane@example.com', '0987654321', CURDATE());

-- Sample Transaction: Issue a Book
INSERT INTO Transactions (book_id, user_id, issue_date, status)
VALUES (1, 1, CURDATE(), 'Issued');

-- Update Book Availability after Issue
UPDATE Books
SET available_copies = available_copies - 1
WHERE book_id = 1;

-- Sample Transaction: Return a Book
UPDATE Transactions
SET return_date = CURDATE(), status = 'Returned'
WHERE transaction_id = 1;

-- Update Book Availability after Return
UPDATE Books
SET available_copies = available_copies + 1
WHERE book_id = 1;

-- Query: Check Availability of Books
SELECT title, available_copies
FROM Books
WHERE available_copies > 0;

-- Query: List All Transactions
SELECT t.transaction_id, b.title, u.name, t.issue_date, t.return_date, t.status
FROM Transactions t
JOIN Books b ON t.book_id = b.book_id
JOIN Users u ON t.user_id = u.user_id;
