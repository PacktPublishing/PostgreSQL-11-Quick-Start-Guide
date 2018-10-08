DO
 $code$
   DECLARE
     file_type text;
   BEGIN
      -- get the biggest file type
      SELECT f_type
      INTO STRICT file_type
      FROM files
      ORDER BY f_size DESC
      LIMIT 1;

      CASE file_type
           WHEN 'txt', 'org' THEN
                RAISE INFO 'Biggest file is a text one';
           WHEN 'png', 'jpg' THEN
                RAISE INFO 'Biggest file is an image one';
           WHEN 'mp3' THEN
                RAISE INFO 'Biggest file is an audio';
           ELSE
                RAISE INFO 'Biggest file is of type %', file_type;
     END CASE;
   END
 $code$;
