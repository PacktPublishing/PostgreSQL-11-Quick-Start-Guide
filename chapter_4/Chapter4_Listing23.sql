CREATE OR REPLACE FUNCTION
f_dump_function( function_name text )
RETURNS SETOF text
AS
  $code$
  DECLARE
    function_count int := 0;
    current_body text;
    current_args text;
    current_returns text;
    current_language text;
    current_volatile text;
    current_security text;
    function_declaration text;
    function_template text;
  BEGIN
    -- how many functions do we have?
    SELECT COUNT( prosrc )
    INTO  function_count
    FROM  pg_proc
    WHERE proname = function_name
    AND   prokind = 'f';

    -- do we have a function with that name?
    IF NOT FOUND THEN
       RAISE EXCEPTION 'No function with the given name found!';
    END IF;

    -- how is supposed the function to look like?
    -- use the format() %I for identifiers and %s for strings
    function_template := $ft$CREATE OR REPLACE FUNCTION
                             %I(%s)
                             RETURNS %s
                             AS $$
                             %s
                             $$
                             LANGUAGE %I
                             SECURITY %s
                             %s;
                          $ft$;


    RAISE DEBUG 'Found % functions with name [%]', function_count, function_name;

    -- iterate on each found entry
    FOR i IN 1 .. function_count LOOP
            SELECT
                  pg_get_function_arguments( pro.oid )
                , pg_get_function_result( pro.oid )
                , pro.prosrc
                , lan.lanname
                , CASE pro.prosecdef WHEN true THEN  'DEFINER'
                                     ELSE 'INVOKER'
                  END
                , CASE pro.provolatile WHEN 'i' THEN 'IMMUTABLE'
                                       WHEN 's' THEN 'STABLE'
                                       ELSE 'VOLATILE'
                  END
            INTO
                current_args,
                current_returns,
                current_body,
                current_language,
                current_security,
                current_volatile
            FROM
                pg_proc pro
                JOIN
                 pg_language lan
                 ON lan.oid = pro.prolang
            WHERE
                pro.proname = function_name
                AND prokind = 'f';  -- regular function

           -- build the function declaration
           function_declaration := format( function_template,
                                           function_name,
                                           current_args,
                                           current_returns,
                                           current_body,
                                           current_language,
                                           current_security,
                                           current_volatile );

            -- this entry is complete
            RETURN NEXT function_declaration;

    END LOOP;

    -- all done
    RETURN;
  END
  $code$
LANGUAGE plpgsql;

