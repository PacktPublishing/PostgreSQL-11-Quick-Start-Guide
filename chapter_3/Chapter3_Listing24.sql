DO
 $code$
 DECLARE
  file_name text;
  file_size numeric;
 BEGIN
  FOR file_name, file_size IN SELECT f_name, f_size
                              FROM files
                              ORDER BY f_name
                              LOOP
      RAISE INFO 'The file % has a size of % bytes',
                             file_name,
                             file_size;
  END LOOP;
 END
 $code$;
