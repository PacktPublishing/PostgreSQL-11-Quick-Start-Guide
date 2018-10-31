DO $code$
 DECLARE
   pi CONSTANT real := 3.14;
   greeting_text CONSTANT text := 'Greetings ';
   people text[] := ARRAY[ 'Mr. Green', 'Mr. Red' ];
   current_person text;
 BEGIN
   FOREACH current_person IN ARRAY people LOOP
      RAISE INFO '% %', greeting_text, current_person;
      RAISE INFO 'Did you know that PI is %?', pi;
   END LOOP;
 END $code$;
