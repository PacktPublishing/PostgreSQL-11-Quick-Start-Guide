INSERT INTO files( f_name, f_hash )
VALUES
( 'chapter2-reviewed.org', '14b8f225d4e6462022657d7285bb77ba' )
ON CONFLICT ( f_hash )
DO UPDATE SET f_name = EXCLUDED.f_name
WHERE files.f_type = 'org';
