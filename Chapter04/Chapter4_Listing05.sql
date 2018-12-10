CREATE OR REPLACE FUNCTION
f_nullable( a int, b text )
RETURNS text
AS
  $code$
  BEGIN
    RAISE INFO 'Invoked with [%] and [%]', a, b;
    RETURN a || b;
  END
  $code$
LANGUAGE plpgsql
STRICT;
