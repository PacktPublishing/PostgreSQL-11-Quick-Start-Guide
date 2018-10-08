CREATE OR REPLACE FUNCTION
f_files_from_directory( dir text DEFAULT '.' )
RETURNS SETOF files
AS
  $code$
  DECLARE
    current_tuple files%rowtype;
    current_file  text;
    name_parts    text[];
    is_dir        bool;
  BEGIN

    RAISE DEBUG 'Reading files into %', dir;

    FOR current_file IN SELECT pg_ls_dir( dir ) LOOP

        RAISE DEBUG 'Building tuple for entry [%]', current_file;

        current_tuple.f_name := current_file;
        -- absolute file name
        current_file := dir || '/' || current_file;

        -- use the real file size and moditification time
        SELECT size, modification, isdir
        FROM   pg_stat_file( current_file )
        INTO   current_tuple.f_size, current_tuple.ts, is_dir;

        -- do not manage directories
        CONTINUE WHEN is_dir;

        -- initialize tuple primary key
        current_tuple.pk = nextval( 'files_pk_seq' );

        -- try to get the type of the file from
        -- its extension
        name_parts := string_to_array( current_tuple.f_name, '.' );
        IF array_length( name_parts, 1 ) > 1 THEN
           current_tuple.f_type := name_parts[ array_length( name_parts, 1 ) ];
        ELSE
          current_tuple.f_type := 'txt';
        END IF;

        -- read the content of the file (not binary!)
        -- and compute an hash
        current_tuple.f_hash := md5( pg_read_file( current_file ) );

        RETURN NEXT current_tuple;

    END LOOP;

    RETURN;
  END
  $code$
LANGUAGE plpgsql;
