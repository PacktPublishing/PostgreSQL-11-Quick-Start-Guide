DO
 $code$
 DECLARE
  current_record record;
 BEGIN
  FOR current_record IN SELECT f_name, f_size
                        FROM files
                        ORDER BY f_name
                        LOOP
      RAISE INFO 'The file % has a size of % bytes',
                             current_record.f_name,
                             current_record.f_size;
  END LOOP;
 END
 $code$;
