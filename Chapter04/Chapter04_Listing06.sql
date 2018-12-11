CREATE OR REPLACE FUNCTION
f_tags_to_string( separator text, VARIADIC tags text[]  )
RETURNS text
AS
   $code$
   DECLARE
    tag_string text;
    current_tag text;
   BEGIN
    FOREACH current_tag IN ARRAY tags LOOP
       IF tag_string IS NULL THEN
          -- first assignment
          tag_string := current_tag;
          CONTINUE;
       END IF;

       tag_string := format( '%s %s %s',
                             tag_string,
                             separator,
                             current_tag );
    END LOOP;

    RETURN tag_string;
   END
   $code$
LANGUAGE plpgsql;
