DO
 $code$
   DECLARE
     file_name text;
     file_size numeric;
   BEGIN
     SELECT f_name, f_size
     INTO STRICT file_name, file_size
     FROM   files
     WHERE  f_type = 'png'
     ORDER BY f_name
     LIMIT 1; -- to make STRICT happy!

     RAISE INFO 'The first png file is %', file_name;
   END
 $code$;
