CREATE OR REPLACE FUNCTION
f_etr_notifier()
RETURNS EVENT_TRIGGER
AS
  $code$
  DECLARE
    event_tuple record;
  BEGIN
    FOR event_tuple IN SELECT *
                       FROM pg_event_trigger_ddl_commands()  LOOP
       RAISE DEBUG 'Event fired by command [%] on [%]',
                   event_tuple.command_tag,    -- statement
                   event_tuple.object_identity;
    END LOOP;

    FOR event_tuple IN SELECT *
                       FROM pg_event_trigger_dropped_objects()  LOOP
      RAISE DEBUG 'Dropped object [%] of type [%]',
                       event_tuple.object_identity,
                       event_tuple.object_type;
    END LOOP;
  END
  $code$
LANGUAGE plpgsql;
