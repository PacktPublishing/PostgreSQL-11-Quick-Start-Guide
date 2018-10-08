DO
 $code$
 BEGIN
    PERFORM pk FROM files;

    IF FOUND THEN
       RAISE DEBUG 'The files tables contain some data';
    END IF;
 END
 $code$;
