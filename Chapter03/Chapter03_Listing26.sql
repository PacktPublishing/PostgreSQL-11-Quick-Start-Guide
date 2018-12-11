DO
 $code$
 DECLARE
   file_hash text := 'f029d04a81c322f158c608596951c105';
 BEGIN
    -- try to perform the insert
    INSERT INTO files( f_name, f_hash )
    VALUES ( 'foo.txt', file_hash );

  EXCEPTION
      -- did the insert fail due to a unique constraint?
      WHEN unique_violation THEN
            UPDATE files
            SET f_name = 'foo.txt'
            WHERE f_hash = file_hash;

     WHEN others THEN
          -- don't know how to recover from other errors
          NULL;
 END;
 $code$;
