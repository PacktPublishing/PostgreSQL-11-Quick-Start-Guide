DO
 $code$
 DECLARE
   file_name text;
   file_size numeric;
   query_string text;
   file_type text;
 BEGIN
   file_type := 'txt';

   -- build the query to execute
   query_string := format( 'SELECT %I, %I FROM %I WHERE %I = $1 LIMIT 1',
                                   'f_name',
                                   'f_size',
                                   'files',
                                   'f_type' );
   -- execute the query
   -- and get back the results
   EXECUTE query_string
   INTO STRICT file_name, file_size
   USING file_type;

   RAISE INFO 'File of type % has name % and size % bytes',
                                                  file_type,
                                                  file_name,
                                                  file_size;
 END
 $code$;
