-- Question 

Write a query to return pairs of projects where the end date of one project matches the start date of another project.

-- Tables
CREATE TABLE projects (
id INTEGER PRIMARY KEY,
title VARCHAR(100),
start_date DATETIME,
end_date DATETIME,
budget FLOAT
);

INSERT INTO projects (id, title, start_date, end_date, budget) VALUES
(1, 'Website Redesign', '2024-01-01', '2024-02-15', 50000),
(2, 'Mobile App Phase 1', '2024-02-15', '2024-04-01', 75000),
(3, 'Database Migration', '2024-04-01', '2024-05-15', 60000),
(4, 'Cloud Integration', '2024-03-01', '2024-04-15', 45000),
(5, 'Security Audit', '2024-05-15', '2024-06-30', 30000);

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema
select p1.title as project_title_end, p2.title as project_title_start, p1.end_date as date from 
  projects p1 join projects p2 on p1.end_date = p2.start_date


  

