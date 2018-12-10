CREATE OR REPLACE FUNCTION
f_etr_avoid_drop_function()
RETURNS EVENT_TRIGGER
AS
  $code$
  DECLARE
    event_tuple record;
  BEGIN
    FOR event_tuple IN SELECT *
                    FROM pg_event_trigger_dropped_objects()  LOOP
      IF event_tuple.object_type = 'function' THEN
         RAISE EXCEPTION 'Cannot drop a function!';
      END IF;
END LOOP;
  END
  $code$
LANGUAGE plpgsql;
