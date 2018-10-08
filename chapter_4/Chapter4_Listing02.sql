CREATE OR REPLACE FUNCTION
f_args( a int,  float, b text )
RETURNS void
AS
  $code$
  BEGIN
    RAISE INFO 'a (type %) = %',
               pg_typeof( a ),
               a;

    RAISE INFO '$2(type %) = %',
               pg_typeof( $2 ),
               $2;

    RAISE INFO 'b (type %) = %',
               pg_typeof( b ),
               b;
   END
   $code$
LANGUAGE plpgsql;
