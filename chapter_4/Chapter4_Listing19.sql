-- first ensure there is the schema
CREATE SCHEMA my_library;

-- and then add the function to the schema
CREATE OR REPLACE FUNCTION
my_library.f_greetings( who text )
RETURNS text
AS
   $code$
   BEGIN
      RETURN 'Hello dear ' || who;
   END
   $code$
LANGUAGE plpgsql
IMMUTABLE;

-- or to move an already existing function
ALTER FUNCTION f_greetings( text ) SET SCHEMA my_library;
