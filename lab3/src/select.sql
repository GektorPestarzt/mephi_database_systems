SELECT *
FROM kanjis
WHERE kanji IN
(
    SELECT kanji
    FROM lists_kanjis
    WHERE list_id = 1
);


SELECT words_kanjis.word, sum(kanjis.strokes) AS strokes
FROM words_kanjis, kanjis
WHERE words_kanjis.kanji = kanjis.kanji
GROUP BY words_kanjis.word
ORDER BY strokes;


SELECT word
FROM lists_words
WHERE list_id = 1
UNION
    SELECT word
    FROM lists_words
    WHERE list_id = 2;


WITH RECURSIVE r (kanji, consist_kanji)
AS (
  SELECT kanji, consist_kanji
  FROM consist_kanjis
  WHERE kanji = '校'

  UNION ALL

  SELECT consist_kanjis.kanji,
		consist_kanjis.consist_kanji
  FROM consist_kanjis, r
  WHERE r.consist_kanji = consist_kanjis.kanji
)
SELECT * FROM r;


SELECT kanji
FROM lists_kanjis
WHERE lists_kanjis.list_id = 1
AND kanji IN
(
	SELECT kanji
	FROM kanjis
	WHERE key = '一'
);


SELECT *
FROM kanjis
WHERE
	readings LIKE '%,キョウ,%' OR
	readings LIKE 'キョウ,%' OR
	readings LIKE '%,キョウ' OR
	readings LIKE 'キョウ';


SELECT ul.id, ul.table_name, str.avarage_strokes
FROM lists_of_kanjis AS ul
JOIN
(
	SELECT lk.list_id, ROUND(AVG(k.strokes),1) AS avarage_strokes
	FROM lists_kanjis AS lk
	JOIN kanjis AS k ON k.kanji = lk.kanji
	GROUP BY lk.list_id
) AS str ON ul.id = str.list_id;


SELECT words .* , kanjis .*
FROM words_kanjis
JOIN kanjis ON words_kanjis . kanji = kanjis . kanji
JOIN words ON words . word = words_kanjis . word
WHERE LENGTH ( words_kanjis . word ) = 1;


SELECT lists_of_words.id AS table_id,
       lists_of_words.table_name,
       COUNT(words_kanjis.kanji) AS count_kanjis,
       SUM(kanjis.strokes) AS sum_strokes,
       ROUND(AVG(kanjis.strokes),1) AS avg_strokes
FROM lists_of_words
JOIN lists_words ON lists_of_words.id = lists_words.list_id
JOIN words_kanjis ON lists_words.word = words_kanjis.word
JOIN
(
    SELECT kanji, strokes
    FROM kanjis
) AS kanjis ON kanjis.kanji = words_kanjis.kanji
GROUP BY lists_of_words.id
ORDER BY avg_strokes
