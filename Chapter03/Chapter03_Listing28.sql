DO
 $code$
 DECLARE
    a real := 10;
    b real := 10;
    c numeric(3,1);
 BEGIN
    LOOP
     BEGIN
      b := b - 5;

      BEGIN
        c := a / b;
        RAISE INFO 'a/b= %', c;
        EXCEPTION
           WHEN division_by_zero THEN
                -- throw another exception
                RAISE EXCEPTION 'b is now zero!';
                b := -1; -- this is never executed!
          END;

      EXIT WHEN b <= -5;
     EXCEPTION
       WHEN others THEN EXIT;
     END;
    END LOOP;
 END;
 $code$;
