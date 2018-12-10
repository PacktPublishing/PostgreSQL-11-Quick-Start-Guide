CREATE OR REPLACE FUNCTION
f_file_by_type( file_type text DEFAULT 'txt' )
RETURNS SETOF files
AS
 $code$
    DECLARE
        current_tuple record;
    BEGIN
      FOR current_tuple IN SELECT * FROM files
                           WHERE f_type = file_type
                           ORDER BY f_name
                           LOOP
         -- append this tuple to the
         -- result set
         RETURN NEXT current_tuple;
      END LOOP;

      --mandatory when done
      RETURN;
    END
 $code$
LANGUAGE plpgsql;
