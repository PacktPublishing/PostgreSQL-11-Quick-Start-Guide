SET client_min_messages TO DEBUG;
BEGIN;
 ALTER TABLE files DROP COLUMN f_size;
ROLLBACK;
