-- Question

Consider the events table, which contains information about the phases of writing a new social media post.

The action column can have values post_enter, post_submit, or post_canceled for when a user starts to write (post_enter), ends up canceling their post (post_cancel), or posts it (post_submit). Write a query to get the post-success rate for each day in the month of January 2020.

Note: Post Success Rate is defined as the number of posts submitted (post_submit) divided by the number of posts entered (post_enter) for each day.
-- Tables

  CREATE TABLE events (
  user_id INT,
  created_at DATETIME,
  action VARCHAR(20)
  );
  
  INSERT INTO events VALUES
  (1, '2020-01-01 10:00:00', 'post_enter'),
  (1, '2020-01-01 10:05:00', 'post_submit'),
  (2, '2020-01-01 11:00:00', 'post_enter'),
  (2, '2020-01-01 11:10:00', 'post_canceled'),
  (3, '2020-01-01 15:00:00', 'post_enter'),
  (3, '2020-01-01 15:30:00', 'post_submit'),
  (4, '2020-01-02 09:00:00', 'post_enter'),
  (4, '2020-01-02 09:15:00', 'post_canceled'),
  (5, '2020-01-02 10:00:00', 'post_enter'),
  (5, '2020-01-02 10:10:00', 'post_canceled'),
  (10, '2020-01-15 14:00:00', 'post_enter'),
  (10, '2020-01-15 14:30:00', 'post_submit'),
  (6, '2019-12-31 23:55:00', 'post_enter'),
  (6, '2020-01-01 00:05:00', 'post_submit'),
  (7, '2020-02-01 00:00:00', 'post_enter'),
  (7, '2020-02-01 00:10:00', 'post_submit'),
  (8, '2019-01-15 10:00:00', 'post_enter'),
  (8, '2019-01-15 10:30:00', 'post_submit'),
  (9, '2021-01-01 09:00:00', 'post_enter'),
  (9, '2021-01-01 09:10:00', 'post_canceled');

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema
SELECT 
    DATE(created_at) AS date,
    SUM(action = 'post_enter') AS total_enters,
    SUM(action = 'post_submit') AS total_submits,
    ROUND(SUM(action = 'post_submit') *1.0  / NULLIF(SUM(action = 'post_enter'), 0), 2) AS success_rate
FROM events
WHERE created_at BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY Date;



) AS user_classification;



