CREATE OR REPLACE FUNCTION
f_files_tuples( fake bool DEFAULT false,
                max int DEFAULT 5 )
RETURNS SETOF files
AS
  $code$
  DECLARE
    current_tuple files%rowtype;
  BEGIN
    IF fake THEN
       FOR i IN 1 .. max LOOP
           current_tuple.pk = nextval( 'files_pk_seq' );
           current_tuple.f_name := initcap( 'file_' || i );
           current_tuple.f_size := random() * 1024 * 1024;

           CASE i % 3
                WHEN 0 THEN current_tuple.f_type := 'txt';
                WHEN 1 THEN current_tuple.f_type := 'png';
                WHEN 2 THEN current_tuple.f_type := 'mp3';
          END CASE;

          current_tuple.f_hash := md5( current_tuple.f_name );
          current_tuple.ts     := now();

          RETURN NEXT current_tuple;
       END LOOP;

       RETURN;
   ELSE
      RETURN QUERY
      SELECT * FROM files
      ORDER BY random()
      LIMIT max;
   END IF;
  END
  $code$
LANGUAGE plpgsql;
