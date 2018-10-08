CREATE OR REPLACE FUNCTION
f_tr_check_hash()
RETURNS TRIGGER
AS
  $code$
  DECLARE
    matches text[];
  BEGIN
    -- check that this is fired
    -- for ROW level, BEFORE, INSERT or UPDATE
    IF TG_LEVEL <> 'ROW'
       OR TG_WHEN <> 'BEFORE'
       OR TG_OP NOT IN ( 'INSERT', 'UPDATE' ) THEN

       RAISE EXCEPTION 'This trigger cannot help you!';
    END IF;

    IF NEW.f_hash IS NULL
       OR length( NEW.f_hash ) = 0 THEN
       RAISE WARNING 'The hash must be specified!';
       -- abort
       RETURN NULL;
    END IF;

    -- hash always in lowercase
    NEW.f_hash := lower( NEW.f_hash );

    matches := regexp_matches( NEW.f_hash, '[abcdef0-9]{32}' );
    IF array_length( matches, 1 ) = 1
      AND matches[ 1 ] = NEW.f_hash THEN
      -- ok
      RETURN NEW;
    ELSE
     -- abort
     RAISE WARNING 'Illegal hash [%]', NEW.f_hash;
     RETURN NULL;
    END IF;

  END
  $code$
LANGUAGE plpgsql;
