CREATE TRIGGER tr_archiver
AFTER
DELETE
ON files           
REFERENCING OLD TABLE AS erasing
FOR EACH STATEMENT
EXECUTE PROCEDURE f_tr_archive_files( 'archive_files' ); 
