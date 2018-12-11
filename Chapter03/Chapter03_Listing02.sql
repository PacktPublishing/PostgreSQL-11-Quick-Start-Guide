DO
 $code$
 DECLARE
  i int  DEFAULT 10;
  t text DEFAULT 'Hello World!';
  j int  DEFAULT 100;
 BEGIN
    RAISE INFO 'Outer block: i = [%] t = [%] j = [%]',
                                               i, t, j;
    -- nested block
    DECLARE
      i text DEFAULT 'PostgreSQL is amazing!';
      t int  DEFAULT 20;
      j int  DEFAULT 999;
    BEGIN
    RAISE INFO 'Inner block i = [%] t = [%] j = [%]',
                                              i, t, j;
    END;

    RAISE INFO 'Outer block: i = [%] t = [%] j = [%]',
                                               i, t, j;
 END;
 $code$;
