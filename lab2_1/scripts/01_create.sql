CREATE SCHEMA kanji;
CREATE SCHEMA word;
CREATE SCHEMA user_collections;

CREATE TABLE kanji.definitions (
  "character" varchar PRIMARY KEY,
  "meaning" text,
  "key" varchar,
  "readings" text,
  "strokes" integer
);

CREATE TABLE kanji.components (
  "parent_character" varchar NOT NULL,
  "component_character" varchar NOT NULL
);

CREATE TABLE word.definitions (
  "word" text PRIMARY KEY,
  "reading" text,
  "meaning" text
);

CREATE TABLE word.kanji_map (
  "character" varchar NOT NULL,
  "word" text NOT NULL
);

CREATE TABLE user_collections.kanji (
  "id" SERIAL PRIMARY KEY,
  "name" text NOT NULL,
  "username" text,
  "description" text
);

CREATE TABLE user_collections.word (
  "id" SERIAL PRIMARY KEY,
  "name" text NOT NULL,
  "username" text,
  "description" text
);

CREATE TABLE user_collections.word_map (
  "word" text NOT NULL,
  "collection_id" int NOT NULL
);

CREATE TABLE user_collections.kanji_map (
  "character" varchar NOT NULL,
  "collection_id" int NOT NULL
);

CREATE TABLE user_collections.user_kanji_collection_map (
  "username" text NOT NULL,
  "collection_id" int NOT NULL
);

CREATE TABLE user_collections.user_word_collection_map (
  "username" text NOT NULL,
  "collection_id" int NOT NULL
);

ALTER TABLE word.kanji_map ADD FOREIGN KEY ("character") REFERENCES kanji.definitions ("character");

ALTER TABLE word.kanji_map ADD FOREIGN KEY ("word") REFERENCES word.definitions ("word");

ALTER TABLE kanji.components ADD FOREIGN KEY ("parent_character") REFERENCES kanji.definitions ("character");

ALTER TABLE kanji.components ADD FOREIGN KEY ("component_character") REFERENCES kanji.definitions ("character");

ALTER TABLE user_collections.user_kanji_collection_map ADD FOREIGN KEY ("collection_id") REFERENCES user_collections.kanji ("id");

ALTER TABLE user_collections.kanji_map ADD FOREIGN KEY ("character") REFERENCES kanji.definitions ("character");

ALTER TABLE user_collections.kanji_map ADD FOREIGN KEY ("collection_id") REFERENCES user_collections.kanji ("id");

ALTER TABLE user_collections.word_map ADD FOREIGN KEY ("collection_id") REFERENCES user_collections.word ("id");

ALTER TABLE user_collections.word_map ADD FOREIGN KEY ("word") REFERENCES word.definitions ("word");

ALTER TABLE user_collections.user_word_collection_map ADD FOREIGN KEY ("collection_id") REFERENCES user_collections.word ("id");
