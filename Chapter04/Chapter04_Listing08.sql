CREATE OR REPLACE FUNCTION
f_file_by_type( file_type text DEFAULT 'txt' )
RETURNS SETOF files
AS
  $code$
  BEGIN
    RETURN QUERY
    SELECT *
    FROM files
    WHERE f_type = file_type
    ORDER BY f_name;
  END
  $code$
LANGUAGE plpgsql;
