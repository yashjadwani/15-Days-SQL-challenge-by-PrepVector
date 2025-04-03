-- Question

Given a table of song_plays and a table of users, write a query to extract the earliest date each user played their third unique song and order by date played.

-- Tables

CREATE TABLE users (
id INTEGER PRIMARY KEY,
username VARCHAR(50)
);

INSERT INTO users (id, username) VALUES
(1, 'john_doe'),
(2, 'jane_smith'),
(3, 'bob_wilson');

CREATE TABLE song_plays (
id INTEGER PRIMARY KEY,
played_at DATETIME,
user_id INTEGER,
song_id INTEGER
);

INSERT INTO song_plays (id, played_at, user_id, song_id) VALUES
(1, '2024-01-01 10:00:00', 1, 101),
(2, '2024-01-01 14:00:00', 1, 101),
(3, '2024-01-02 09:00:00', 1, 102),
(4, '2024-01-03 16:00:00', 1, 103),
(5, '2024-01-04 11:00:00', 1, 104),
(6, '2024-01-01 09:00:00', 2, 201),
(7, '2024-01-01 15:00:00', 2, 202),
(8, '2024-01-02 10:00:00', 2, 203),
(9, '2024-01-02 14:00:00', 2, 203),
(10, '2024-01-01 12:00:00', 3, 301),
(11, '2024-01-02 13:00:00', 3, 302);

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema
WITH song_ranking AS (
    SELECT 
        user_id, 
        song_id, 
        played_at, 
        ROW_Number() OVER (PARTITION BY user_id ORDER BY played_at) AS song_rank
    FROM (
        SELECT DISTINCT user_id, song_id, played_at
        FROM song_plays
    ) AS unique_songs
)
SELECT 
    u.username, 
    s.song_id, 
    s.played_at AS created_at
FROM users u
JOIN song_ranking s ON u.id = s.user_id
WHERE s.song_rank = 3
ORDER BY s.played_at;


