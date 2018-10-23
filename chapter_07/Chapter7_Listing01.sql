CREATE OR REPLACE VIEW
vw_text_files
AS
SELECT *
FROM files
WHERE f_type = 'txt';
