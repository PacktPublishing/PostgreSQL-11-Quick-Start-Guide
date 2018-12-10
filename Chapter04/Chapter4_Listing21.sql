SELECT prosrc
FROM pg_proc
WHERE proname = 'f_files_from_directory'
AND   prokind = 'f';
