WITH get_files_by_hash AS (
     SELECT pk, name FROM files WHERE f_hash like 'abc%' )
SELECT name FROM get_files_by_hash;
