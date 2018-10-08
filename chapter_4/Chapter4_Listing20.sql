CREATE FUNCTION pg_temp.f_greetings( who text )
RETURNS text
AS
  $code$
  BEGIN
    RETURN 'Hello dear ' || who;
  END
  $code$
LANGUAGE plpgsql;

