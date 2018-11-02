SET client_min_messages TO debug;
ALTER TABLE files ALTER COLUMN f_type SET DEFAULT NULL;
INSERT INTO files( f_name, f_hash )
         VALUES( 'chapter5.pdf', '14b87625d4e6462cc2657daa85bb77bb' );

UPDATE files SET f_name = 'chapter5.odt' WHERE f_name = 'chapter5.pdf';
