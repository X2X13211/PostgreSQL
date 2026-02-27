
INSERT INTO books (title, price)
VALUES ('Изучаем SQL', 1500.00);

UPDATE books
SET price = 1600.00
WHERE id = 1;

DELETE FROM books
WHERE id = 11;



SELECT COUNT(*) AS total_books
FROM books;

SELECT SUM(price) AS total_price
FROM books;

SELECT AVG(price) AS average_price
FROM books;

SELECT MAX(price) AS max_price, MIN(price) AS min_price
FROM books;

SELECT c.name AS category_name, COUNT(bc.book_id) AS books_count
FROM categories c
JOIN book_categories bc ON c.id = bc.category_id
GROUP BY c.id, c.name
HAVING COUNT(bc.book_id) > 1;



SELECT b.title, c.name AS category
FROM books b
INNER JOIN book_categories bc ON b.id = bc.book_id
INNER JOIN categories c ON bc.category_id = c.id;

SELECT b.title, c.name AS category
FROM books b
LEFT JOIN book_categories bc ON b.id = bc.book_id
LEFT JOIN categories c ON bc.category_id = c.id;

SELECT b.title, c.name AS category
FROM books b
RIGHT JOIN book_categories bc ON b.id = bc.book_id
RIGHT JOIN categories c ON bc.category_id = c.id;

SELECT b.title, c.name AS category
FROM books b
FULL JOIN book_categories bc ON b.id = bc.book_id
FULL JOIN categories c ON bc.category_id = c.id;

SELECT b.title, c.name AS category
FROM books b
CROSS JOIN categories c;
