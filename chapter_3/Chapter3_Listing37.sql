DO
 $code$
   DECLARE
    file_type text := 'png';
   BEGIN
    PERFORM (
      WITH biggest_file_by_type AS (
         SELECT f_name
         FROM   files
         WHERE  f_type = file_type
         ORDER  BY f_size DESC
         LIMIT 1
      )
      SELECT f_name
      FROM biggest_file_by_type
    );

    RAISE INFO 'I''m survived!';

   END
 $code$;
