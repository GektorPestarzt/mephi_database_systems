CREATE TABLE kanjis (
  kanji TEXT PRIMARY KEY,
  meaning TEXT,
  key TEXT,
  readings TEXT,
  strokes INTEGER
);

CREATE TABLE consist_kanjis (
  kanji TEXT NOT NULL,
  consist_kanji TEXT NOT NULL,
  FOREIGN KEY (kanji) REFERENCES kanjis(kanji),
  FOREIGN KEY (consist_kanji) REFERENCES kanjis(kanji)
);

CREATE TABLE words (
  word TEXT PRIMARY KEY,
  reading TEXT,
  meaning TEXT
);

CREATE TABLE words_kanjis (
  word TEXT NOT NULL,
  kanji TEXT NOT NULL,
  FOREIGN KEY (word) REFERENCES words(word),
  FOREIGN KEY (kanji) REFERENCES kanjis(kanji)
);

CREATE TABLE users_lists_of_kanjis (
  username TEXT NOT NULL,
  list_id INTEGER NOT NULL,
  FOREIGN KEY (list_id) REFERENCES lists_of_kanjis(id)
);

CREATE TABLE lists_of_kanjis (
  id INTEGER PRIMARY KEY,
  username TEXT,
  table_name TEXT NOT NULL,
  description TEXT
);

CREATE TABLE lists_of_words (
  id INTEGER PRIMARY KEY,
  username TEXT,
  table_name TEXT NOT NULL,
  description TEXT
);

CREATE TABLE lists_words (
  list_id INTEGER NOT NULL,
  word TEXT NOT NULL,
  FOREIGN KEY (list_id) REFERENCES lists_of_words(id),
  FOREIGN KEY (word) REFERENCES words(word)
);

CREATE TABLE lists_kanjis (
  list_id INTEGER NOT NULL,
  kanji TEXT NOT NULL,
  FOREIGN KEY (list_id) REFERENCES lists_of_kanjis(id),
  FOREIGN KEY (kanji) REFERENCES kanjis(kanji)
);

CREATE TABLE users_lists_of_words (
  username TEXT NOT NULL,
  list_id INTEGER NOT NULL,
  FOREIGN KEY (list_id) REFERENCES lists_of_words(id)
);
