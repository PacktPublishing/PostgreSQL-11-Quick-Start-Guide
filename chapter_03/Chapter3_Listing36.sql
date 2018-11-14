DO
 $code$
 DECLARE
  file_type text := 'png';
 BEGIN
  -- ok
  PERFORM now();

  PERFORM -- SELECT
          f_size, f_name
          FROM files
          WHERE f_type = file_type -- interpolation
          ORDER BY f_size DESC;

  RAISE INFO 'I''ve survived!';
 END
 $code$;
