SELECT id, username, table_name
FROM lists_of_words;

SELECT kanji, meaning, readings
FROM kanjis
WHERE strokes < 5;

SELECT kanji, meaning, readings
FROM kanjis
ORDER BY strokes;

SELECT kanji, count(*)
FROM words_kanjis
GROUP BY kanji
ORDER BY count(*) DESC;

SELECT word, count(*)
FROM words_kanjis
GROUP BY word
ORDER BY count(*) DESC;

SELECT w.word, w.meaning, w.reading
FROM words_kanjis AS wk
JOIN words AS w ON w.word = wk.word
WHERE kanji='口';

SELECT DISTINCT wk.kanji
FROM lists_words AS lw
JOIN words_kanjis AS wk ON lw.word = wk.word
WHERE lw.list_id = 1;

SELECT DISTINCT uk.username, count(*)
FROM users_lists_of_kanjis AS uk
JOIN lists_kanjis AS lk ON lk.list_id = uk.list_id
GROUP BY uk.username;

