DO
 $code$
 DECLARE
   counter int := 0;
 BEGIN
   LOOP
      counter := counter + 1;
      RAISE INFO 'This is the % time I say HELLO!', counter;
      IF counter > 3 THEN
         EXIT;
      END IF;
   END LOOP;

   RAISE INFO 'Good bye';
 END
 $code$;
