DO
 $code$
   DECLARE
      file_name text     := 'TestFile.txt';
      file_size numeric  := 123.56;
      file_pk   int;
      file_ts   timestamp;
   BEGIN
      -- insert a new file and get back the key
      INSERT INTO files( f_name, f_size )
      VALUES ( file_name, file_size )
      RETURNING pk
      INTO file_pk;

      RAISE INFO 'File [%] has been inserted with pk = %',
                                            file_name,
                                            file_pk;

     -- query back to get the ts column
     SELECT ts
     INTO   file_ts
     FROM   files
     WHERE  pk = file_pk;

     RAISE INFO 'Timestamp is %', file_ts;

   END
 $code$;
