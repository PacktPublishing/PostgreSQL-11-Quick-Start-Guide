DO $code$ #variable_conflict use_variable
DECLARE
  f_type text := 'png';
  file_size text;
  file_name text;
  BEGIN
     SELECT f_size, f_name
     INTO STRICT file_size, file_name
     FROM   files
     WHERE  f_type = f_type  -- f_type = 'png'
     ORDER BY f_size DESC
     LIMIT 1;
     RAISE INFO 'Biggest % file is %', f_type, file_name;
END $code$;
