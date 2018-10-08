BEGIN;

INSERT INTO files_archive
SELECT * FROM files;

-- can use also a TRUNCATE
DELETE FROM files;

COMMIT;
