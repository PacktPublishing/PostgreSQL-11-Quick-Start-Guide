/*
 * This is a psql script that creates the table structure and puts
 * some data into the tables.
 *
 * Execute the script from `psql` using the '\i' operator:
 *     \i 00-table-structure.sql
 */

BEGIN;

\echo 'Creating tables...';

\i 01-files-table.sql

\i 02-tags-table.sql

\i 03-join-table.sql

\i 04-archive_files-table.sql

\i 05-playlist-table.sql




\echo 'Emptying tables...';
TRUNCATE files CASCADE;
TRUNCATE tags  CASCADE;



\echo 'Resetting sequences...';
ALTER TABLE files        ALTER COLUMN pk RESTART;
ALTER TABLE tags         ALTER COLUMN pk RESTART;
ALTER TABLE j_files_tags ALTER COLUMN pk RESTART;
ALTER TABLE playlist     ALTER COLUMN pk RESTART;


\echo 'Inserting data...';
INSERT INTO tags( t_name )
VALUES
( 'holidays' )
, ( 'sicily' )
, ( 'family' )
, ( 'music' )
, ( 'rock' )
, ( 'pop' )
, ( 'hard rock' )
, ( 'metallica' )
, ( 'foo fighters' )
, ( '2017' )
, ( '2018' );

UPDATE tags
SET t_child_of = ( SELECT pk FROM tags WHERE t_name = 'hard rock' )
WHERE t_name IN ( 'metallica', 'foo fighters' );

UPDATE tags
SET t_child_of = ( SELECT pk FROM tags WHERE t_name = 'music' )
WHERE t_name IN ( 'pop', 'rock', 'hard rock' );

UPDATE tags
SET t_child_of = ( SELECT pk FROM tags WHERE t_name = 'holidays' )
WHERE t_name IN ( 'sicily' );

UPDATE tags
SET t_child_of = ( SELECT pk FROM tags WHERE t_name = 'sicily' )
WHERE t_name like '201_';

INSERT INTO tags( t_name )
VALUES( '2018' ); -- this is a root tag



INSERT INTO files( f_name, f_hash, f_size, f_type )
VALUES
  ( 'chapter1.org', 'f029d04a81c322f158c608596951c105', 10.5,  'org' )
, ( 'chapter2.org', '14b8f225d4e6462022657d7285bb77ba', 22.4,  'org' )
, ( 'chapter3.org', '14b87625d4e6462022657daa85bb77cc', 36.4,  'org' )
, ( 'picture1.png', '22347625d4e6462022657daa85bb77a1', 120.8,  'png' )
, ( 'picture2.png', '323412345666462022657daa85bb77a2', 520.1,  'png' )
, ( 'picture3.png', '823412345666462022657daa85bb77a3', 300,    'png' )
, ( 'audio1.mp3',   'fdeab2345666462022657daa85bb77bb', 157.65, 'mp3' )
, ( 'audio2.mp3',   'fdddb2345666462022657daa85bb1234', 221.5,  'mp3' )
, ( 'audio3.mp3',   'dffff2345666462022657daa85bbaa22', 21.5,   'mp3' )
;

INSERT INTO j_files_tags( f_pk, t_pk )
SELECT f.pk, t.pk
FROM files f, tags t
WHERE f.f_type = 'mp3'
AND   ( t.t_name = 'metallica' OR t.t_name = 'music' OR t.t_name = 'hard rock' );

INSERT INTO j_files_tags( f_pk, t_pk )
SELECT f.pk, t.pk
FROM files f, tags t
WHERE f.f_type = 'png'
AND   ( t.t_name = 'sicily' OR t.t_name = 'family' );



\echo 'Inspecting the data...'

SELECT
  f.f_name
  , f.f_size
  , f.f_type
  , substring( f.f_hash FROM 1 FOR 10 ) AS hash
  , array_to_string( array_agg( t.t_name ), ', ' )
FROM
  files f
JOIN
  j_files_tags j
  ON j.f_pk = f.pk
JOIN
  tags t
  ON t.pk = j.t_pk
GROUP BY 1, 2, 3, 4
ORDER BY f.f_name;


COMMIT;
\echo 'all done!';
