CREATE OR REPLACE FUNCTION
f_tr_infer_file_type_from_extension()
RETURNS TRIGGER
AS
  $code$
  DECLARE
    name_parts text[];
    computed_file_type text;
  BEGIN
    -- check that this is fired
    -- for ROW level, BEFORE, INSERT or UPDATE
    IF TG_LEVEL <> 'ROW'
       OR TG_WHEN <> 'BEFORE'
       OR TG_OP NOT IN ( 'INSERT', 'UPDATE' ) THEN

       RAISE EXCEPTION 'This trigger cannot help you!';
    END IF;


    name_parts := string_to_array( NEW.f_name, '.' );
    IF array_length( name_parts, 1 ) > 1 THEN
       -- got the extension
       computed_file_type := name_parts[ array_length( name_parts, 1 ) ];
    ELSE
      computed_file_type := NULL;
    END IF;


    IF TG_OP = 'INSERT' THEN
       IF NEW.f_type IS NULL THEN
          -- here infer the type from the name
          NEW.f_type := computed_file_type;
       ELSE
         RAISE DEBUG 'Explicitly specified file type % on INSERT', NEW.f_type;
       END IF;
    ELSE
      -- update case

      IF NEW.f_type IS NULL THEN
         IF OLD.f_type IS NOT NULL THEN
            RAISE DEBUG 'Preserve old file type %', OLD.f_type;
            NEW.f_type := OLD.f_type;
        ELSE
            RAISE DEBUG 'Switch NULL type to %', computed_file_type;
            NEW.f_type := computed_file_type;
       END IF;
      END IF;

      IF NEW.f_type = OLD.f_type
         AND NEW.f_name <> OLD.f_name THEN

         RAISE DEBUG 'Name updated from % to % but no type changed', NEW.f_name, OLD.f_name;

         IF computed_file_type <> NEW.f_type THEN
            RAISE DEBUG 'Name update lead to file type %', computed_file_type;
            NEW.f_type := computed_file_type;
         END IF;

     END IF;
    END IF;

    -- proceed
    RETURN NEW;

  END
  $code$
LANGUAGE plpgsql;
