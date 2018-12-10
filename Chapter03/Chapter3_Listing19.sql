DO
 $code$
 DECLARE
   counter       int := 0;
   inner_counter int := 0;
 BEGIN
   <<MAIN_LOOP>>
   LOOP
      counter := counter + 1;
      -- skip to the next iteration if counter is a multiple of 3
      CONTINUE WHEN counter % 3 = 0;
      RAISE INFO 'This is the % time I say HELLO!', counter;

      inner_counter := 0;

      <<INNER_LOOP>>
      LOOP
        inner_counter := inner_counter + 1;
        -- restart from the outer loop when inner_counter is a multiple of 2
        CONTINUE MAIN_LOOP WHEN inner_counter % 2 = 0;
        RAISE INFO 'I do repeat: HELLO!';
        -- exit from this loop
        EXIT WHEN inner_counter > 0;
      END LOOP;

      EXIT WHEN counter >= 10;
   END LOOP;

   RAISE INFO 'Good bye';
 END
 $code$;
