DO
 $code$
   DECLARE
      i int;  -- initial value is NULL
      t text := 'Hello World!';
      d date := CURRENT_DATE;
   BEGIN
      RAISE INFO 'Variables are: d = [%], t = [%], i = [%]',
                                                     d, t, i;

     -- single assignment
     i := length( t );
     d := now();  -- coerced to 'date'

     -- multiple assignment!
     SELECT 'Happy new ' || EXTRACT( year FROM d ) + 1 || ' year!', i * i
     INTO   t, i;

     RAISE INFO 'Variables now are: d = [%], t = [%], i = [%]',
                                                         d, t, i;
   END
 $code$;
