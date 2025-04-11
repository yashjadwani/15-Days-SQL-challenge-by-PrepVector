-- Question

Given a table of transactions and products, write a function to get the month_over_month change in revenue for the year 2019. Make sure to round month_over_month to 2 decimal places.

-- Tables

CREATE TABLE transactions (
id INT PRIMARY KEY,
product_id INT,
quantity INT,
created_at TIMESTAMP,
FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO transactions (id, product_id, quantity, created_at) VALUES
(1, 101, 2, '2019-01-15 10:00:00'),
(2, 102, 1, '2019-01-20 12:30:00'),
(3, 101, 3, '2019-02-10 14:00:00'),
(4, 103, 1, '2019-02-25 16:15:00'),
(5, 102, 4, '2019-03-05 09:30:00'),
(6, 101, 1, '2019-03-18 13:45:00');

CREATE TABLE products (
id INT PRIMARY KEY,
price DECIMAL(10, 2)
);

INSERT INTO products (id, price) VALUES
(101, 20.00),
(102, 15.00),
(103, 30.00);

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

WITH monthly_revenues AS
(
    SELECT CAST(STRFTIME('%m', created_at) AS INT) AS month,
           CAST(SUM(quantity * price) AS FLOAT) AS revenue
    FROM transactions t
    JOIN products p
ON t.product_id = p.id
    GROUP BY month
)
SELECT month,
       ROUND(((revenue - LAG(revenue) OVER(ORDER BY month ASC)) /
              (LAG(revenue) OVER(ORDER BY month ASC)) * 100), 2)
       AS month_over_month
FROM monthly_revenues;


