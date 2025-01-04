/*

Find the most popular song with the most plays and least skips, in that order.

A skip is when the song hasn't been played the whole way through.

Submit the song name.

*/

/*

Skills used:
    CTE
    count

*/

-- My solution
SELECT
    songs.song_title,
    COUNT(*) AS total_plays,
    COUNT(*) FILTER( 
        WHERE user_plays.duration IS NULL 
        OR (user_plays.duration < songs.song_duration)
    ) AS total_skips
FROM user_plays
INNER JOIN songs ON user_plays.song_id = songs.song_id
GROUP BY songs.song_title
ORDER BY total_plays DESC, total_skips DESC;



/*

Test Querys

*/

SELECT
    user_plays.play_id,
    songs.song_title,
    songs.song_duration,
    user_plays.duration AS play_duration
FROM user_plays
INNER JOIN songs ON user_plays.song_id = songs.song_id;

SELECT *
FROM users
LIMIT 10;

SELECT *
FROM songs
LIMIT 10;

SELECT *
FROM user_plays
LIMIT 10;

