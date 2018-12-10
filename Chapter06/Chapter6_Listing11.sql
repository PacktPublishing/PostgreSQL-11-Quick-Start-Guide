DROP TRIGGER IF EXISTS tr_infer_file_type ON files;

CREATE TRIGGER tr_infer_file_type
BEFORE
INSERT OR UPDATE
ON files
FOR EACH ROW
WHEN ( NEW.f_type IS NULL )
EXECUTE PROCEDURE f_tr_infer_file_type_from_extension();
