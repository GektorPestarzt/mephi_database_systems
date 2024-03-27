CREATE TABLE kanjis (
  id INTEGER PRIMARY KEY,
  kanji VARCHAR UNIQUE,
  meaning TEXT,
  radicals_id INTEGER,
  consist_kanjis_id INTEGER,
  readings_id INTEGER,
  strokes INTEGER
);

CREATE TABLE radicals (
  id INTEGER PRIMARY KEY,
  radical VARCHAR UNIQUE,
  readings_id INTEGER,
  strokes INTEGER
);

CREATE TABLE words (
  id INTEGER PRIMARY KEY,
  word TEXT UNIQUE,
  meaning TEXT,
  kanjis_id INTEGER
);

CREATE TABLE readings (
  id INTEGER PRIMARY KEY,
  reading TEXT UNIQUE
);

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  username TEXT UNIQUE,
  lists_id INTEGER
);

CREATE TABLE lists (
  id INTEGER PRIMARY KEY,
  name TEXT,
  kanjis_id INTEGER
);

CREATE TABLE radicals_kanjis (
  radicals_id INTEGER,
  kanjis_radicals_id INTEGER,
  PRIMARY KEY (radicals_id, kanjis_radicals_id),
  FOREIGN KEY (radicals_id) REFERENCES radicals (id),
  FOREIGN KEY (kanjis_radicals_id) REFERENCES kanjis (radicals_id)
);

CREATE TABLE kanjis_words (
  kanjis_id INTEGER,
  words_kanjis_id INTEGER,
  PRIMARY KEY (kanjis_id, words_kanjis_id),
  FOREIGN KEY (kanjis_id) REFERENCES kanjis (id),
  FOREIGN KEY (words_kanjis_id) REFERENCES words (kanjis_id)
);

CREATE TABLE kanjis_kanjis (
  kanjis_id INTEGER,
  kanjis_consist_kanjis_id INTEGER,
  PRIMARY KEY (kanjis_id, kanjis_consist_kanjis_id),
  FOREIGN KEY (kanjis_id) REFERENCES kanjis (id),
  FOREIGN KEY (kanjis_consist_kanjis_id) REFERENCES kanjis (consist_kanjis_id)
);

CREATE TABLE readings_kanjis (
  readings_id INTEGER,
  kanjis_readings_id INTEGER,
  PRIMARY KEY (readings_id, kanjis_readings_id),
  FOREIGN KEY (readings_id) REFERENCES readings (id),
  FOREIGN KEY (kanjis_readings_id) REFERENCES kanjis (readings_id)
);

CREATE TABLE readings_radicals (
  readings_id INTEGER,
  radicals_readings_id INTEGER,
  PRIMARY KEY (readings_id, radicals_readings_id),
  FOREIGN KEY (readings_id) REFERENCES readings (id),
  FOREIGN KEY (radicals_readings_id) REFERENCES radicals (readings_id)
);

CREATE TABLE kanjis_lists (
  kanjis_id INTEGER,
  lists_kanjis_id INTEGER,
  PRIMARY KEY (kanjis_id, lists_kanjis_id),
  FOREIGN KEY (kanjis_id) REFERENCES kanjis (id),
  FOREIGN KEY (lists_kanjis_id) REFERENCES lists (kanjis_id)
);

CREATE TABLE lists_users (
  lists_id INTEGER,
  users_lists_id INTEGER,
  PRIMARY KEY (lists_id, users_lists_id),
  FOREIGN KEY (lists_id) REFERENCES lists (id),
  FOREIGN KEY (users_lists_id) REFERENCES users (lists_id)
);
