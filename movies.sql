CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    genre VARCHAR(50),
    duration_min INT CHECK (duration_min > 0) NOT NULL,
    ticket_price NUMERIC(10, 2) DEFAULT 0.00,
    rating VARCHAR(10),
    is_3d BOOLEAN DEFAULT FALSE,
    release_date DATE
);

INSERT INTO movies (title, genre, duration_min, ticket_price, rating, is_3d, release_date) VALUES
    ('Интерстеллар', 'Фантастика', 169, 500.00, '12+', FALSE, '2014-11-06'),
    ('Безумный Макс: Дорога ярости', 'Боевик', 120, 600.00, '18+', TRUE, '2015-05-14'),
    ('Головоломка', 'Мультфильм', 95, 300.00, '6+', TRUE, '2015-06-18'),
    ('Дюна: Часть вторая', 'Фантастика', 166, 750.00, '12+', TRUE, '2024-03-01'),
    ('Крепкий орешек', 'Боевик', 132, 400.00, '16+', FALSE, '1988-07-15'),
    ('Король Лев', 'Мультфильм', 88, 250.00, '0+', FALSE, '1994-06-15');

UPDATE movies
SET ticket_price = ticket_price + 50
WHERE genre = 'Фантастика';

DELETE FROM movies
WHERE id = 5;

UPDATE movies
SET rating = '16+'
WHERE title = 'Интерстеллар';

SELECT title, ticket_price
FROM movies
WHERE duration_min > 120;

SELECT *
FROM movies
ORDER BY ticket_price ASC;

SELECT COUNT(*) AS total_movies
FROM movies;

SELECT AVG(ticket_price) AS average_ticket_price
FROM movies;

SELECT genre, COUNT(*) AS movies_count
FROM movies
GROUP BY genre;

SELECT genre
FROM movies
GROUP BY genre
HAVING AVG(ticket_price) > 350;
