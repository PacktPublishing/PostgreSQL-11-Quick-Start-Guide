CREATE TRIGGER tr_infer_file_type
BEFORE
INSERT OR UPDATE
ON files
FOR EACH ROW
EXECUTE PROCEDURE f_tr_infer_file_type_from_extension();
