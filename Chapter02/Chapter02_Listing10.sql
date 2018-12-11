WITH get_files_by_hash AS (
     SELECT pk, f_name FROM files WHERE f_hash like 'abc%' )
SELECT f_name FROM get_files_by_hash;
