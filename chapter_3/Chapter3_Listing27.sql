DO
 $code$
 DECLARE
    a real := 10;
    b real := 10;
    c numeric(3,1);
 BEGIN
    LOOP
      b := b - 5;

      BEGIN
        c := a / b;
        RAISE INFO 'a/b= %', c;
        EXCEPTION
           WHEN division_by_zero THEN
                RAISE INFO 'b is now zero!';
                b := -1;
          END;

      EXIT WHEN b <= -5;
    END LOOP;
 END;
 $code$;
