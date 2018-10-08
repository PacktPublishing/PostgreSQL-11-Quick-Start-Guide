CREATE OR REPLACE FUNCTION
f_args( int, float, text )
RETURNS void
AS
  $code$
  BEGIN
    RAISE INFO '$1 (type %) = %',
               pg_typeof( $1 ),
               $1;

    RAISE INFO '$2 (type %) = %',
               pg_typeof( $2 ),
               $2;

   RAISE INFO '$3 (type %) = %',
               pg_typeof( $3 ),
               $3;
  END
  $code$
LANGUAGE plpgsql;
