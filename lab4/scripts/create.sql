CREATE TABLE "kanjis" (
  "kanji" varchar PRIMARY KEY,
  "meaning" text,
  "key" varchar,
  "readings" text,
  "strokes" integer
);

CREATE TABLE "consist_kanjis" (
  "kanji" varchar NOT NULL,
  "consist_kanji" varchar NOT NULL
);

CREATE TABLE "words" (
  "word" text PRIMARY KEY,
  "reading" text,
  "meaning" text
);

CREATE TABLE "words_kanjis" (
  "word" varchar NOT NULL,
  "kanji" varchar NOT NULL
);

CREATE TABLE "users_lists_of_kanjis" (
  "username" text NOT NULL,
  "list_id" int NOT NULL
);

CREATE TABLE "lists_of_kanjis" (
  "id" integer PRIMARY KEY,
  "username" text,
  "table_name" text NOT NULL,
  "description" text
);

CREATE TABLE "lists_of_words" (
  "id" integer PRIMARY KEY,
  "username" text,
  "table_name" text NOT NULL,
  "description" text
);

CREATE TABLE "lists_words" (
  "list_id" int NOT NULL,
  "word" text NOT NULL
);

CREATE TABLE "lists_kanjis" (
  "list_id" int NOT NULL,
  "kanji" varchar NOT NULL
);

CREATE TABLE "users_lists_of_words" (
  "username" text NOT NULL,
  "list_id" int NOT NULL
);

ALTER TABLE "words_kanjis" ADD FOREIGN KEY ("kanji") REFERENCES "kanjis" ("kanji");

ALTER TABLE "words_kanjis" ADD FOREIGN KEY ("word") REFERENCES "words" ("word");

ALTER TABLE "consist_kanjis" ADD FOREIGN KEY ("kanji") REFERENCES "kanjis" ("kanji");

ALTER TABLE "consist_kanjis" ADD FOREIGN KEY ("consist_kanji") REFERENCES "kanjis" ("kanji");

ALTER TABLE "users_lists_of_kanjis" ADD FOREIGN KEY ("list_id") REFERENCES "lists_of_kanjis" ("id");

ALTER TABLE "lists_kanjis" ADD FOREIGN KEY ("kanji") REFERENCES "kanjis" ("kanji");

ALTER TABLE "lists_kanjis" ADD FOREIGN KEY ("list_id") REFERENCES "lists_of_kanjis" ("id");

ALTER TABLE "lists_words" ADD FOREIGN KEY ("list_id") REFERENCES "lists_of_words" ("id");

ALTER TABLE "lists_words" ADD FOREIGN KEY ("word") REFERENCES "words" ("word");

ALTER TABLE "users_lists_of_words" ADD FOREIGN KEY ("list_id") REFERENCES "lists_of_words" ("id");
