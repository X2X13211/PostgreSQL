CREATE TABLE inventory (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150),
    category VARCHAR(50),
    price NUMERIC(10, 2),
    quantity INT,
    is_available BOOLEAN DEFAULT true
);

INSERT INTO inventory (name, category, price, quantity, is_available) VALUES
    ('Принтер лазерный', 'Оргтехника', 12000.00, 3, true),
    ('Бумага A4 (коробка)', 'Расходные материалы', 2500.00, 50, true),
    ('Стол офисный', 'Мебель', 8500.00, 10, true),
    ('Кресло эргономичное', 'Мебель', 15000.00, 4, true),
    ('Монитор 24 дюйма', 'Оргтехника', 9000.00, 0, false),
    ('Ноутбук рабочий', 'Оргтехника', 45000.00, 12, true),
    ('Ручки шариковые (набор)', 'Канцтовары', 300.00, 100, true),
    ('Картридж для принтера', 'Расходные материалы', 4500.00, 2, true),
    ('Шкаф для документов', 'Мебель', 11000.00, 0, false),
    ('Монитор 27 дюймов изогнутый', 'Оргтехника', 18000.00, 5, true),
    ('Маркеры (набор)', 'Канцтовары', 450.00, 20, true),
    ('Папки скоросшиватели', 'Канцтовары', 120.00, 200, true);

SELECT name, quantity
FROM inventory;

SELECT *
FROM inventory
WHERE quantity < 5;

SELECT name, category, price
FROM inventory
WHERE price >= 1000 AND price <= 10000;

SELECT *
FROM inventory
WHERE category IN ('Мебель', 'Оргтехника');

SELECT *
FROM inventory
WHERE name ILIKE '%Монитор%';

SELECT *
FROM inventory
WHERE is_available = false;

SELECT *
FROM inventory
ORDER BY price DESC
LIMIT 3;

SELECT *
FROM inventory
ORDER BY category ASC, name ASC;
