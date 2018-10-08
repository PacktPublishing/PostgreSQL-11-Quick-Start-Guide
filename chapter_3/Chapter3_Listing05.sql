DO
 $code$
   DECLARE
     file_name text;
     file_size numeric;
   BEGIN
     SELECT f_name, f_size
     INTO   file_name, file_size
     FROM   files
     WHERE  f_type = 'png'
     ORDER BY f_name;

     RAISE INFO 'The first png file is %', file_name;
   END
 $code$;
