CREATE OR REPLACE FUNCTION
f_tr_notifier()
RETURNS TRIGGER
AS
  $code$
  BEGIN
    -- display some information about what fired me up
    RAISE DEBUG 'Trigger [%] fired [%] [%] [%] against %.%',
                TG_NAME,     -- trigger name
                TG_WHEN,     -- BEFORE, AFTER, INSTEAD OF
                TG_OP,       -- INSERT, UPDATE, DELETE, TRUNCATE
                TG_LEVEL,    -- ROW, STATEMENT
                TG_TABLE_SCHEMA, TG_TABLE_NAME;

   -- this can executed only for low level triggers
   IF TG_LEVEL <> 'ROW' THEN
      RAISE EXCEPTION 'This trigger function can be invoked only for row-level triggers!';
   END IF;

   IF TG_OP = 'INSERT' THEN
      -- here only NEW is defined
      RAISE DEBUG 'NEW tuple: pk = %', NEW.pk;
   ELSIF TG_OP = 'UPDATE' THEN
      -- here both NEW and OLD are defined
      RAISE DEBUG 'NEW tuple pk = %, OLD tuple pk = %', NEW.pk, OLD.pk;
   ELSIF TG_OP = 'DELETE' THEN
     -- here only OLD is defined
     RAISE DEBUG 'OLD tuple pk = %', OLD.pk;
   END IF;

   -- abort the current operation
   RETURN NULL;

  END
  $code$
LANGUAGE plpgsql;
