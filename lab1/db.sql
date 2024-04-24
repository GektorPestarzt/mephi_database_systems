CREATE TABLE kanjis (
  kanji TEXT PRIMARY KEY,
  meaning TEXT,
  key TEXT,
  strokes INTEGER
);

CREATE TABLE consist_kanjis (
  kanji TEXT NOT NULL,
  consist_kanji TEXT NOT NULL,
  FOREIGN KEY (kanji) REFERENCES kanjis (kanji),
  FOREIGN KEY (consist_kanji) REFERENCES kanjis (kanji)
);

CREATE TABLE kanjis_radicals (
  kanji TEXT NOT NULL,
  radical TEXT NOT NULL,
  FOREIGN KEY (kanji) REFERENCES kanjis (kanji),
  FOREIGN KEY (radical) REFERENCES radicals (radical)
);

CREATE TABLE kanjis_readings (
  kanji TEXT NOT NULL,
  reading_id INTEGER NOT NULL,
  FOREIGN KEY (kanji) REFERENCES kanjis (kanji),
  FOREIGN KEY (reading_id) REFERENCES readings (id)
);

CREATE TABLE radicals (
  radical TEXT PRIMARY KEY,
  reading_id INTEGER,
  meaning TEXT,
  FOREIGN KEY (reading_id) REFERENCES readings (id)
);

CREATE TABLE words (
  word TEXT PRIMARY KEY,
  meaning TEXT
);

CREATE TABLE words_kanjis (
  word TEXT NOT NULL,
  kanji TEXT NOT NULL,
  FOREIGN KEY (word) REFERENCES words (word),
  FOREIGN KEY (kanji) REFERENCES kanjis (kanji)
);

CREATE TABLE readings (
  id INTEGER PRIMARY KEY,
  reading TEXT UNIQUE
);

CREATE TABLE users (
  username TEXT PRIMARY KEY
);

CREATE TABLE users_lists (
  username TEXT NOT NULL,
  list_id INTEGER NOT NULL,
  FOREIGN KEY (username) REFERENCES users (username),
  FOREIGN KEY (list_id) REFERENCES lists (id)
);

CREATE TABLE lists (
  id INTEGER PRIMARY KEY,
  username TEXT,
  table_name TEXT NOT NULL,
  description TEXT
);

CREATE TABLE lists_kanjis (
  list_id INTEGER NOT NULL,
  kanji TEXT NOT NULL,
  FOREIGN KEY (list_id) REFERENCES lists (id),
  FOREIGN KEY (kanji) REFERENCES kanjis (kanji)
);
