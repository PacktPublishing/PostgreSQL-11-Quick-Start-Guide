WITH
 deleting_files AS ( DELETE FROM files RETURNING * )
INSERT INTO files_archive
SELECT * FROM deleting_files;
