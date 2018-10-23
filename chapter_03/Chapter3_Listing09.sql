DO $code$
DECLARE
  file_name text;
  file_size numeric;
  size_kb int := 1024;
  size_mb numeric := size_kb * size_kb;
  size_gb numeric := size_mb * size_mb;
  unit text;
  BEGIN
      -- get the max file size
      SELECT max( f_size )
      INTO file_size
      FROM files;

      CASE
            WHEN file_size > size_kb THEN
                 file_size := file_size / size_kb;
                 unit := 'kB';
            WHEN file_size > size_mb THEN
                 file_size := file_size / size_mb;
                 unit := 'MB';
            WHEN file_size > size_gb THEN
                 file_size := file_size / size_gb;
                 unit := 'GB';
           ELSE
                unit := 'bytes';
      END CASE;
      RAISE INFO 'Biggest file size is % %', file_size, unit;
END $code$;
