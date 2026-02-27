CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE specialties (
    id SERIAL PRIMARY KEY,
    spec_name VARCHAR(100) NOT NULL,
    dept_id INT REFERENCES departments(id)
);

INSERT INTO departments (dept_name) VALUES
    ('Кафедра ИТ'),
    ('Кафедра Физики'),
    ('Кафедра Истории');

INSERT INTO specialties (spec_name, dept_id) VALUES
    ('Разработка ПО', 1),
    ('Квантовая механика', 2),
    ('Астрофизика', NULL),
    ('Искусственный интеллект', NULL);

SELECT d.dept_name, s.spec_name
FROM departments d
INNER JOIN specialties s ON d.id = s.dept_id;

SELECT d.dept_name, s.spec_name
FROM departments d
LEFT JOIN specialties s ON d.id = s.dept_id;

SELECT d.dept_name, s.spec_name
FROM departments d
RIGHT JOIN specialties s ON d.id = s.dept_id;

SELECT d.dept_name, s.spec_name
FROM departments d
FULL JOIN specialties s ON d.id = s.dept_id;
