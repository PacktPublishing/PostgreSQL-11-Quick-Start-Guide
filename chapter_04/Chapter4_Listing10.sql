CREATE OR REPLACE FUNCTION
f_fake_files( max int DEFAULT 10 )
RETURNS SETOF files
AS
 $code$
    DECLARE
      current_tuple files%rowtype;
    BEGIN
      IF max <= 0 THEN
         RAISE EXCEPTION 'Specify a positive limit for tuple generation';
      END IF;


      FOR i IN 1 .. max LOOP
          current_tuple.pk = nextval( 'files_pk_seq' );
          current_tuple.f_name := initcap( 'file_' || i );
          current_tuple.f_size := random() * 1024 * 1024 / random();

          CASE i % 3
               WHEN 0 THEN current_tuple.f_type := 'txt';
               WHEN 1 THEN current_tuple.f_type := 'png';
               WHEN 2 THEN current_tuple.f_type := 'mp3';
          END CASE;

          current_tuple.f_hash := md5( current_tuple.f_name );
          current_tuple.ts     := now();

          RAISE DEBUG '%) % generated', i, current_tuple.pk;
          RETURN NEXT current_tuple;
      END LOOP;

      RETURN;
    END
 $code$
LANGUAGE plpgsql;
