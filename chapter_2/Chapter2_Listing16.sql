WITH
 inserting_files AS ( INSERT INTO files_archive
                      SELECT * FROM files
                      RETURNING pk )
DELETE FROM files
WHERE pk IN ( SELECT pk FROM )inserting_files );
