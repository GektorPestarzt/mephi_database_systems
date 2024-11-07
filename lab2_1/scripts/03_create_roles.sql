CREATE ROLE admin WITH LOGIN CREATEDB CREATEROLE;
CREATE ROLE privileged_developer WITH CREATEDB NOINHERIT;
CREATE ROLE developer WITH LOGIN NOINHERIT;
CREATE ROLE content_creator WITH LOGIN NOINHERIT;
CREATE ROLE content_user WITH LOGIN NOINHERIT;

-- admin
GRANT ALL PRIVILEGES ON DATABASE japanese_db TO admin WITH GRANT OPTION;

DO $$ 
DECLARE
    schema TEXT;
    schemas_array TEXT[] := ARRAY['kanji', 'word', 'user_collections'];
BEGIN
    FOREACH schema IN ARRAY schemas_array
    LOOP
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA %I TO admin WITH GRANT OPTION;', schema);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA %I TO admin WITH GRANT OPTION;', schema);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA %I TO admin WITH GRANT OPTION;', schema);
        EXECUTE format('GRANT ALL PRIVILEGES ON SCHEMA %I TO admin WITH GRANT OPTION;', schema);
    END LOOP;
END $$;

-- privileged_developer
GRANT ALL PRIVILEGES ON DATABASE japanese_db TO privileged_developer;

DO $$ 
DECLARE
    schema TEXT;
    schemas_array TEXT[] := ARRAY['kanji', 'word', 'user_collections'];
BEGIN
    FOREACH schema IN ARRAY schemas_array
    LOOP
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA %I TO privileged_developer;', schema);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA %I TO privileged_developer;', schema);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA %I TO privileged_developer;', schema);
        EXECUTE format('GRANT ALL PRIVILEGES ON SCHEMA %I TO privileged_developer;', schema);
    END LOOP;
END $$;

-- developer
GRANT ALL PRIVILEGES ON DATABASE japanese_db TO developer;

DO $$ 
DECLARE
    schema TEXT;
    schemas_array TEXT[] := ARRAY['kanji', 'word', 'user_collections'];
BEGIN
    FOREACH schema IN ARRAY schemas_array
    LOOP
        EXECUTE format('GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA %I TO developer;', schema);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA %I TO developer;', schema);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA %I TO developer;', schema);
        EXECUTE format('GRANT ALL PRIVILEGES ON SCHEMA %I TO developer;', schema);
    END LOOP;
END $$;

-- content_creator
GRANT CONNECT ON DATABASE japanese_db TO content_creator;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA kanji TO content_creator;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA word TO content_creator;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA user_collections TO content_creator;

GRANT SELECT, USAGE ON ALL SEQUENCES IN SCHEMA user_collections TO content_creator;

GRANT USAGE ON SCHEMA kanji TO content_creator;
GRANT USAGE ON SCHEMA word TO content_creator;
GRANT USAGE ON SCHEMA user_collections TO content_creator;

-- content_user
GRANT CONNECT ON DATABASE japanese_db TO content_user;

GRANT SELECT ON ALL TABLES IN SCHEMA kanji TO content_user;
GRANT SELECT ON ALL TABLES IN SCHEMA word TO content_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA user_collections TO content_user;

GRANT SELECT, USAGE ON ALL SEQUENCES IN SCHEMA user_collections TO content_user;

GRANT USAGE ON SCHEMA kanji TO content_user;
GRANT USAGE ON SCHEMA word TO content_user;
GRANT USAGE ON SCHEMA user_collections TO content_user;


GRANT privileged_developer TO developer;

DO $$ 
BEGIN
    EXECUTE format('ALTER ROLE admin WITH PASSWORD %L', current_setting('ADMIN_PASSWORD', true));
    EXECUTE format('ALTER ROLE developer WITH PASSWORD %L', current_setting('DEVELOPER_PASSWORD', true));
    EXECUTE format('ALTER ROLE content_creator WITH PASSWORD %L', current_setting('CONTENT_CREATOR_PASSWORD', true));
    EXECUTE format('ALTER ROLE content_user WITH PASSWORD %L', current_setting('CONTENT_USER_PASSWORD', true));
END $$;