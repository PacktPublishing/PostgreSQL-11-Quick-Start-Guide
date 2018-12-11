CREATE OR REPLACE FUNCTION
f_fake_small_files( max int DEFAULT 10,
                    pk OUT int,
                    file_name OUT text,
                    file_type OUT text )
RETURNS SETOF record
AS
 $code$
    BEGIN
      IF max <= 0 THEN
         RAISE EXCEPTION 'Specify a positive limit for tuple generation';
      END IF;


      FOR i IN 1 .. max LOOP
          pk = nextval( 'files_pk_seq' );
          file_name := initcap( 'file_' || i );

          CASE i % 3
               WHEN 0 THEN file_type := 'txt';
               WHEN 1 THEN file_type := 'png';
               WHEN 2 THEN file_type := 'mp3';
          END CASE;

          RETURN NEXT;
      END LOOP;

      RETURN;
    END
 $code$
LANGUAGE plpgsql;
