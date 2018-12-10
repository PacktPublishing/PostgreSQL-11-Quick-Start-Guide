DO
 $code$
 DECLARE
   counter int := 0;
 BEGIN
   LOOP
      counter := counter + 1;
      RAISE INFO 'This is the % time I say HELLO!', counter;
      EXIT WHEN counter > 3;
   END LOOP;

   RAISE INFO 'Good bye';
 END
 $code$;
