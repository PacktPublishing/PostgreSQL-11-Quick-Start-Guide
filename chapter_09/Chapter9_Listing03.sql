DO
  $code$
  DECLARE
    payload text;
  BEGIN
    FOR i IN 1 .. 250000 LOOP
        payload := 'Event ' || i;
        PERFORM pg_notify( 'insert_table', payload );
    END LOOP;
  END
  $code$
LANGUAGE plpgsql;
