CREATE TABLE Production (
    production_id SERIAL PRIMARY KEY,
    date DATE,
    machine VARCHAR(50),
    product VARCHAR(50),
    planned_qty INT,
    actual_qty INT,
    defect_qty INT,
    working_hours NUMERIC(5,2)
);
CREATE TABLE Inventory (
    inventory_id SERIAL PRIMARY KEY,
    date DATE,
    product VARCHAR(50),
    opening_stock INT,
    produced INT,
    sold INT,
    closing_stock INT
);
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    product VARCHAR(50),
    order_date DATE,
    delivery_date DATE,
    promised_date DATE
);
CREATE TABLE Machine (
    machine_id SERIAL PRIMARY KEY,
    machine VARCHAR(50),
    capacity_per_hour INT
);
INSERT INTO Machine (machine, capacity_per_hour) VALUES
('M1', 100),
('M2', 120),
('M3', 90),
('M4', 110),
('M5', 95);
INSERT INTO Production (date, machine, product, planned_qty, actual_qty, defect_qty, working_hours)
SELECT
    CURRENT_DATE - (random() * 30)::int,
    ('M' || (1 + floor(random() * 5))::int),
    ('P' || (1 + floor(random() * 4))::int),
    (700 + floor(random() * 300))::int,
    (650 + floor(random() * 300))::int,
    (10 + floor(random() * 50))::int,
    round((6 + random() * 4)::numeric,2)
FROM generate_series(1,10);
INSERT INTO Inventory (date, product, opening_stock, produced, sold, closing_stock)
SELECT
    CURRENT_DATE - (random() * 30)::int,
    ('P' || (1 + floor(random() * 4))::int),
    (200 + floor(random() * 300))::int,
    (500 + floor(random() * 500))::int,
    (300 + floor(random() * 400))::int,
    (400 + floor(random() * 400))::int
FROM generate_series(1,10);
INSERT INTO Orders (product, order_date, promised_date, delivery_date)
SELECT
    ('P' || (1 + floor(random() * 4))::int),
    CURRENT_DATE - (random() * 20)::int,
    CURRENT_DATE + (random() * 10)::int,
    CURRENT_DATE + (random() * 15)::int
FROM generate_series(1,10);

