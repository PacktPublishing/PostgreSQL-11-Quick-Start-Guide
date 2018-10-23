DO
 $code$
 DECLARE
    size_array numeric[];
    current_size numeric( 8,2 );
 BEGIN
    -- store the sizes into the array
    SELECT array_agg( f_size )
    INTO   size_array
    FROM   files;

    FOREACH current_size IN ARRAY size_array LOOP
       RAISE INFO 'Current size is %', current_size;
    END LOOP;
 END
 $code$;
