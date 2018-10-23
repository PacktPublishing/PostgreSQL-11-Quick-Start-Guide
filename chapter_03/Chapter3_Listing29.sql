SET client_show_min_messages TO debug;
DO $code$
BEGIN
  RAISE DEBUG 'A debug message';
  RAISE INFO  'An info message';
END $code$;

-- DEBUG:  A debug message
-- INFO:  An info message

SET client_show_min_messages TO info;
DO $code$
BEGIN
  RAISE DEBUG 'A debug message';
  RAISE INFO  'An info message';
END $code$;

--INFO:  An info message
SET client_show_min_messages TO debug;
