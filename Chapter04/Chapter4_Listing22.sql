SELECT
  pro.proname AS function_name
  , pg_get_function_arguments( pro.oid ) AS arguments
  , pg_get_function_result( pro.oid )  AS returns
  , pro.prosrc AS code_block
  , lan.lanname AS language
FROM
  pg_proc pro
JOIN
  pg_language lan
  ON lan.oid = pro.prolang
WHERE
  pro.proname = 'f_files_from_directory'
AND pro.prokind = 'f';
