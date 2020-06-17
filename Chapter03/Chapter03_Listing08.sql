DO $code$ 
 DECLARE
    file_type text := 'png';
    file_size text;
    file_name text;
 BEGIN
   SELECT f_size, f_name
   INTO STRICT file_size, file_name
   FROM   files
   WHERE  f_type = file_type  
   ORDER BY f_size DESC
   LIMIT 1;
   RAISE INFO 'Biggest % file is %', file_type, file_name;
 END $code$;
