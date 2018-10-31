BEGIN;

INSERT INTO archive_files
SELECT * FROM files;

-- can use also a TRUNCATE
DELETE FROM files;

COMMIT;
