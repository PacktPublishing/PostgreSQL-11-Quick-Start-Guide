CREATE OR REPLACE FUNCTION
f_args( a IN int,
        INOUT float,
        b OUT text )
RETURNS record
AS
  $code$
  BEGIN
    b := 'The real value was  ' || $2;
    $2 := a * $2;
 END
   $code$
LANGUAGE plpgsql;
