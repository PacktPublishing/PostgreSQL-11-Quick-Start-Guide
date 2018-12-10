DO
 $code$
 DECLARE
   counter       int := 0;
   inner_counter int := 0;
 BEGIN
   <<MAIN_WHILE>>
   WHILE counter < 5 LOOP
         counter := counter + 1;

         RAISE INFO 'This is the % time I say HELLO!', counter;

         inner_counter := counter;

         <<INNER_WHILE>>
         WHILE inner_counter > 0 LOOP
               RAISE INFO 'I do repeat: HELLO!';
               inner_counter := inner_counter - 1;
         END LOOP;

   END LOOP;

   RAISE INFO 'Good bye';
 END
 $code$;
