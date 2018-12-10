DO
 $code$
 BEGIN
  FOR counter IN EXTRACT( month FROM CURRENT_DATE ) .. 12 LOOP
      RAISE INFO 'The month % I say HELLO', counter;
  END LOOP;

  FOR counter IN REVERSE 5 .. 1 BY 1 LOOP
      RAISE INFO 'This is the % time I say HELLO', counter;
  END LOOP;
 END
 $code$;
