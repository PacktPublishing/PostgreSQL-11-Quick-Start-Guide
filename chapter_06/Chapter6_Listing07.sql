CREATE OR REPLACE FUNCTION
f_tr_infer_file_type_from_extension()
RETURNS TRIGGER
AS
  $code$
  DECLARE
    name_parts text[];
  BEGIN
    -- check that this is fired
    -- for ROW level, BEFORE, INSERT or UPDATE
    IF TG_LEVEL <> 'ROW'
       OR TG_WHEN <> 'BEFORE'
       OR TG_OP NOT IN ( 'INSERT', 'UPDATE' ) THEN

       RAISE EXCEPTION 'This trigger cannot help you!';
    END IF;

    -- if the user has specified a f_type,
    -- do not override it
    IF NEW.f_type IS NOT NULL AND TG_OP = 'INSERT' THEN
          RAISE DEBUG 'Preserving file type %', NEW.f_type;
    ELSE
      -- here we need to compute the file type

          name_parts := string_to_array( NEW.f_name, '.' );
          IF array_length( name_parts, 1 ) > 1 THEN
             -- got the extension
             NEW.f_type := name_parts[ array_length( name_parts, 1 ) ];
             RAISE DEBUG 'Automatically selected file type %', NEW.f_type;
         ELSE
             NEW.f_type := 'txt';
             RAISE DEBUG 'No name extension, using default file type txt';
         END IF;
    END IF;

    -- proceed
    RETURN NEW;

  END
  $code$
LANGUAGE plpgsql;
