DO $code$
DECLARE
   page_size CONSTANT int := 8;
   database_name CONSTANT text := 'PostgreSQL';
   BEGIN
         RAISE INFO '% page size is % kilobytes by default', database_name,  page_size;

         page_size := page_size * 2;
         RAISE INFO 'but you can change to % kB at compile time', page_size;
         database_name := 'MySQL';
         RAISE INFO 'or switch to % if you are unhappy!', database_name;
END $code$;
