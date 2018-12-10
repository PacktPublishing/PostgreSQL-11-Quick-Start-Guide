DO
 $code$
 DECLARE
  current_record record;
 BEGIN
  RAISE DEBUG 'In the beginning FOUND = %', FOUND;

  FOR current_record IN SELECT *
                        FROM files
                        LIMIT 3
                    LOOP
   RAISE DEBUG 'While iterating FOUND = %', FOUND;

   IF current_record.pk % 2 = 0 THEN
     -- this statement will fail
     PERFORM pk
     FROM files
     WHERE f_hash = 'FAIL' || current_record.f_hash;

     RAISE DEBUG 'After a failing statement FOUND = %', FOUND;
   ELSE
      -- this statement will succeed
      PERFORM pk
      FROM files
      WHERE f_hash = current_record.f_hash;

      RAISE DEBUG 'After a succeeding statement FOUND = %', FOUND;
   END IF;


  END LOOP;

  RAISE DEBUG 'Outside the loop FOUND = %', FOUND;

 END
 $code$;
