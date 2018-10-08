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


    IF NEW.f_type IS NULL THEN
       RAISE DEBUG 'Setting default file type to %', TG_ARGV[ 0 ];
       NEW.f_type := TG_ARGV[ 0 ];
    END IF;

    -- proceed
    RETURN NEW;

  END
  $code$
LANGUAGE plpgsql;
