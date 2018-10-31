WITH
 deleting_files AS ( DELETE FROM files RETURNING * )
INSERT INTO archive_files
SELECT * FROM deleting_files;
