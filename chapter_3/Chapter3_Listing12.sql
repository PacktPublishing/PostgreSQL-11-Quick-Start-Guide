DO
 $code$
 DECLARE
   a int := 10;
   b ALIAS FOR a;
 BEGIN
    RAISE INFO 'a is %, b is %', a ,b;

    -- will impact 'a'
    b := b * 2;

    RAISE INFO 'a is %, b is %', a ,b;
 END
 $code$;
