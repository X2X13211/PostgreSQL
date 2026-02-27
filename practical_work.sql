-- Этап 1: Создание архитектуры

-- 1. Таблица books (Книги)
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    price NUMERIC(10, 2)
);

-- 2. Таблица categories (Категории/Жанры)
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

-- 3. Таблица book_categories (Связующая)
CREATE TABLE book_categories (
    book_id INT REFERENCES books(id),
    category_id INT REFERENCES categories(id),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (book_id, category_id)
);

-- Этап 2: Наполнение данными

-- 1. Категории (10 шт)
INSERT INTO categories (name) VALUES
    ('Фантастика'),
    ('Детектив'),
    ('Роман'),
    ('Психология'),
    ('Бизнес'),
    ('Программирование'),
    ('История'),
    ('Триллер'),
    ('Детское'),
    ('Классика');

-- 2. Книги (10 шт, цены от 100 до 2000 руб)
INSERT INTO books (title, price) VALUES
    ('Дюна', 1500.00),
    ('Убийство в Восточном экспрессе', 800.50),
    ('Гордость и предубеждение', 600.00),
    ('Игры, в которые играют люди', 1200.00),
    ('Богатый папа, бедный папа', 1100.00),
    ('Совершенный код', 1900.00),
    ('Sapiens. Краткая история человечества', 1800.00),
    ('Молчание ягнят', 900.00),
    ('Гарри Поттер и философский камень', 1300.00),
    ('Мастер и Маргарита', 750.00);

-- 3. Связи
-- Минимум 3 книги имеют более одной категории
-- Минимум одна категория осталась пустой (без книг) - категория 'Бизнес' (id=5) не будет использована.
INSERT INTO book_categories (book_id, category_id) VALUES
    (1, 1),   -- Дюна: Фантастика (1 категория)
    (2, 2), (2, 8), -- Убийство в Восточном экспрессе: Детектив, Триллер (2 категории)
    (3, 3), (3, 10), -- Гордость и предубеждение: Роман, Классика (2 категории)
    (4, 4),   -- Игры, в которые играют люди: Психология (1 категория)
    (6, 6),   -- Совершенный код: Программирование (1 категория)
    (7, 7),   -- Sapiens: История (1 категория)
    (8, 8), (8, 2), (8, 4), -- Молчание ягнят: Триллер, Детектив, Психология (3 категории)
    (9, 1), (9, 9), -- Гарри Поттер: Фантастика, Детское (2 категории)
    (10, 10), (10, 1), (10, 3); -- Мастер и Маргарита: Классика, Фантастика, Роман (3 категории)

-- В результате книги №2, 3, 8, 9, 10 имеют несколько категорий (всего 5 книг, условие > 3 выполнено).
-- Категория 'Бизнес' (5) осталась пустой.


-- Этап 3: Аналитические отчеты

-- Задача 1: Полный каталог
-- Вывести список всех книг и их жанров.
SELECT b.title AS "Название книги", c.name AS "Жанр"
FROM books b
JOIN book_categories bc ON b.id = bc.book_id
JOIN categories c ON bc.category_id = c.id;

-- Задача 2: Поиск по жанру
-- Вывести все книги, которые относятся к категории 'Программирование'.
SELECT b.title AS "Название книги", b.price AS "Цена"
FROM books b
JOIN book_categories bc ON b.id = bc.book_id
JOIN categories c ON bc.category_id = c.id
WHERE c.name = 'Программирование';

-- Задача 3: Статистика жанров (Агрегация + JOIN)
-- Посчитать, сколько книг представлено в каждом жанре. Вывести жанры, где книг больше 2.
SELECT c.name AS "Название жанра", COUNT(bc.book_id) AS "Количество книг"
FROM categories c
JOIN book_categories bc ON c.id = bc.category_id
GROUP BY c.id, c.name
HAVING COUNT(bc.book_id) > 2;

-- Задача 4: Стоимость категорий
-- Найти среднюю цену книг для каждой категории. Отсортировать от самых дорогих жанров к самым дешевым.
SELECT c.name AS "Название жанра", ROUND(AVG(b.price), 2) AS "Средняя цена"
FROM categories c
JOIN book_categories bc ON c.id = bc.category_id
JOIN books b ON bc.book_id = b.id
GROUP BY c.id, c.name
ORDER BY AVG(b.price) DESC;

-- Задача 5: Книги-универсалы
-- Вывести названия книг, которые входят более чем в 2 категории одновременно.
SELECT b.title AS "Название книги", COUNT(bc.category_id) AS "Количество категорий"
FROM books b
JOIN book_categories bc ON b.id = bc.book_id
GROUP BY b.id, b.title
HAVING COUNT(bc.category_id) > 2;
