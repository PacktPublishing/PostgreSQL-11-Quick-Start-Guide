DO
 $code$
 DECLARE
   counter       int := 0;
   inner_counter int := 0;
 BEGIN
   <<MAIN_LOOP>>
   LOOP
      counter := counter + 1;
      RAISE INFO 'This is the % time I say HELLO!', counter;

      inner_counter := 0;

      <<INNER_LOOP>>
      LOOP
        inner_counter := inner_counter + 1;
        RAISE INFO 'I do repeat: HELLO!';
        -- exit from this loop
        EXIT WHEN inner_counter >= 2;
        -- terminate also the main loop
        EXIT MAIN_LOOP WHEN inner_counter >= 4;
      END LOOP;

      EXIT WHEN counter >= 10;
   END LOOP;

   RAISE INFO 'Good bye';
 END
 $code$;
