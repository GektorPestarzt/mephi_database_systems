SELECT id, username, name
FROM user_collections.word;

SELECT character, meaning, readings
FROM kanji.definitions
WHERE strokes < 5;

SELECT character, meaning, readings
FROM kanji.definitions
ORDER BY strokes;

SELECT character, count(*)
FROM word.kanji_map
GROUP BY character
ORDER BY count(*) DESC;

SELECT word, count(*)
FROM word.kanji_map
GROUP BY word
ORDER BY count(*) DESC;

SELECT w.word, w.meaning, w.reading
FROM word.kanji_map AS wk
JOIN word.definitions AS w ON w.word = wk.word
WHERE character='口';

SELECT DISTINCT wk.character
FROM user_collections.word_map AS cw_map
JOIN word.kanji_map AS wk ON cw_map.word = wk.word
WHERE cw_map.collection_id = 1;

SELECT DISTINCT uk_map.username, count(*)
FROM user_collections.user_kanji_collection_map AS uk_map
JOIN user_collections.kanji_map AS lk ON lk.collection_id = uk_map.collection_id
GROUP BY uk_map.username;