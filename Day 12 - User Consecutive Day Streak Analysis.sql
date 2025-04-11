-- Question

Given a table with event logs, find the top five users with the longest continuous streak of visiting the platform in 2020.

Note: A continuous streak counts if the user visits the platform at least once per day on consecutive days.

-- Tables

CREATE TABLE events (
user_id INT,
created_at DATETIME,
url VARCHAR(255)
);

-- Generating comprehensive sample data with interrupted streaks
INSERT INTO events (user_id, created_at, url) VALUES

(1, '2019-12-30 10:00:00', 'https://example.com/2019-page1'),
(1, '2019-12-31 11:00:00', 'https://example.com/2019-page2'),
(2, '2019-11-15 12:00:00', 'https://example.com/2019-profile1'),
(2, '2019-11-16 13:00:00', 'https://example.com/2019-profile2'),
(3, '2019-10-20 14:00:00', 'https://example.com/2019-blog1'),
(4, '2019-09-25 16:00:00', 'https://example.com/2019-review1'),
(4, '2019-09-26 17:00:00', 'https://example.com/2019-review2'),
(5, '2019-08-30 18:00:00', 'https://example.com/2019-summer1'),
(5, '2019-08-31 19:00:00', 'https://example.com/2019-summer2'),
(6, '2019-07-15 20:00:00', 'https://example.com/2019-page1'),
(6, '2019-07-16 21:00:00', 'https://example.com/2019-page2'),
(1, '2020-01-01 10:00:00', 'https://example.com/page1'),
(1, '2020-01-02 11:00:00', 'https://example.com/page2'),
(1, '2020-01-04 12:00:00', 'https://example.com/page3'),
(1, '2020-01-05 13:00:00', 'https://example.com/page4'),
(1, '2020-01-06 14:00:00', 'https://example.com/page5'),
(1, '2020-01-07 12:00:00', 'https://example.com/page7'),
(1, '2020-01-08 12:00:00', 'https://example.com/page8'),
(1, '2020-01-09 12:00:00', 'https://example.com/page9'),
(1, '2020-01-10 12:00:00', 'https://example.com/page10'),
(2, '2020-02-10 15:00:00', 'https://example.com/dashboard'),
(2, '2020-02-11 16:00:00', 'https://example.com/profile'),
(2, '2020-02-12 17:00:00', 'https://example.com/settings'),
(2, '2020-02-14 18:00:00', 'https://example.com/messages'),
(2, '2020-02-15 19:00:00', 'https://example.com/notifications'),
(2, '2020-02-16 20:00:00', 'https://example.com/search'),
(2, '2020-02-17 21:00:00', 'https://example.com/help'),
(2, '2020-02-18 21:00:00', 'https://example.com/help2'),
(3, '2020-03-15 22:00:00', 'https://example.com/blog'),
(3, '2020-05-20 01:00:00', 'https://example.com/products'),
(3, '2020-05-22 02:00:00', 'https://example.com/cart'),
(4, '2020-12-28 04:00:00', 'https://example.com/year-end'),
(4, '2020-12-30 05:00:00', 'https://example.com/review'),
(4, '2020-12-31 06:00:00', 'https://example.com/summary'),
(5, '2020-04-01 08:00:00', 'https://example.com/spring1'),
(5, '2020-04-02 09:00:00', 'https://example.com/spring2'),
(5, '2020-07-15 10:00:00', 'https://example.com/summer1'),
(5, '2020-07-17 11:00:00', 'https://example.com/summer2'),
(5, '2020-07-18 12:00:00', 'https://example.com/summer3'),
(5, '2020-10-20 13:00:00', 'https://example.com/autumn1'),
(6, '2020-06-01 15:00:00', 'https://example.com/page1'),
(6, '2020-06-02 16:00:00', 'https://example.com/page2'),
(6, '2020-06-03 17:00:00', 'https://example.com/page3'),
(6, '2020-06-04 18:00:00', 'https://example.com/page4'),
(6, '2020-06-05 19:00:00', 'https://example.com/page5'),
(6, '2020-06-06 20:00:00', 'https://example.com/page6'),
(6, '2020-06-07 21:00:00', 'https://example.com/page7'),
(6, '2020-06-08 22:00:00', 'https://example.com/page8'),
(6, '2020-06-09 23:00:00', 'https://example.com/page9'),
(6, '2020-06-10 00:00:00', 'https://example.com/page10'),
(7, '2020-08-01 01:00:00', 'https://example.com/august1'),
(7, '2020-08-02 02:00:00', 'https://example.com/august2'),
(7, '2020-08-03 03:00:00', 'https://example.com/august3'),
(7, '2020-08-04 03:00:00', 'https://example.com/august6'),
(8, '2020-09-11 05:00:00', 'https://example.com/september2'),
(9, '2020-11-15 06:00:00', 'https://example.com/november1'),
(9, '2020-11-16 07:00:00', 'https://example.com/november2'),
(9, '2020-11-17 08:00:00', 'https://example.com/november3'),
(10, '2020-05-01 09:00:00', 'https://example.com/may1'),
(10, '2020-05-02 10:00:00', 'https://example.com/may2'),
(1, '2021-01-01 22:00:00', 'https://example.com/2021-page1'),
(1, '2021-01-02 23:00:00', 'https://example.com/2021-page2'),
(2, '2021-02-10 00:00:00', 'https://example.com/2021-profile1'),
(2, '2021-02-11 01:00:00', 'https://example.com/2021-profile2'),
(3, '2021-03-15 02:00:00', 'https://example.com/2021-blog1'),
(3, '2021-03-16 03:00:00', 'https://example.com/2021-blog2'),
(4, '2021-04-20 04:00:00', 'https://example.com/2021-review1'),
(4, '2021-04-21 05:00:00', 'https://example.com/2021-review2'),
(5, '2021-05-25 06:00:00', 'https://example.com/2021-summer1'),
(5, '2021-05-26 07:00:00', 'https://example.com/2021-summer2'),
(6, '2021-06-30 08:00:00', 'https://example.com/2021-page1'),
(6, '2021-07-01 09:00:00', 'https://example.com/2021-page2'),
(11, '2020-01-15 10:00:00', 'https://example.com/complex1'),
(11, '2020-01-16 11:00:00', 'https://example.com/complex2'),
(11, '2020-01-18 12:00:00', 'https://example.com/complex3'),
(11, '2020-01-19 13:00:00', 'https://example.com/complex4'),
(12, '2020-04-10 14:00:00', 'https://example.com/scenario1'),
(12, '2020-04-11 15:00:00', 'https://example.com/scenario2'),
(12, '2020-04-13 16:00:00', 'https://example.com/scenario3'),
(12, '2020-04-14 17:00:00', 'https://example.com/scenario4');

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema
WITH daily_visits AS (
    SELECT
        user_id,
        DATE(created_at) AS visit_date
    FROM events
    WHERE STRFTIME('%Y', created_at) = '2020'
    GROUP BY user_id, DATE(created_at)
),
streaks AS (
    SELECT
        user_id,
        visit_date,
        CASE WHEN
            visit_date = DATE(LAG(visit_date) OVER (PARTITION BY user_id ORDER BY visit_date), '+1 day')
        THEN 0 ELSE 1 END AS is_new_streak
    FROM daily_visits
),
grouped_streaks AS (
    SELECT
        user_id,
        visit_date,
        SUM(is_new_streak) OVER (PARTITION BY user_id ORDER BY visit_date) AS streak_group
    FROM streaks
),
streak_lengths AS (
    SELECT
        user_id,
        COUNT(*) AS streak_length
    FROM grouped_streaks
    GROUP BY user_id, streak_group
)
SELECT
    user_id,
    MAX(streak_length) AS streak_length
FROM streak_lengths
GROUP BY user_id
ORDER BY streak_length DESC
LIMIT 5;
