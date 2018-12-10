CREATE OR REPLACE FUNCTION
f_test_shadow( p1 int DEFAULT 1, p2 text DEFAULT 'Hello' )
RETURNS void
AS
  $code$
  DECLARE
    p1 char(2) := 'P1'; -- masks function argument!
    p3 int     := 10;
  BEGIN
    RAISE DEBUG 'p1 is %', p1;

    DECLARE
      p3 text := 'Gosh!'; -- masks outer block variable!
    BEGIN
     RAISE DEBUG 'p3 is %', p3;
    END;

    RAISE DEBUG 'p2 is %', p2;
  END
  $code$
LANGUAGE plpgsql;
