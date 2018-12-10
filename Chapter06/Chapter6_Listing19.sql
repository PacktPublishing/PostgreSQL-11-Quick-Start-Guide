CREATE OR REPLACE FUNCTION
f_tr_archive_files()
RETURNS TRIGGER
AS
  $code$
  DECLARE
    current_tuple files%rowtype;
  BEGIN

    FOR current_tuple IN SELECT * FROM erasing LOOP
        RAISE DEBUG 'Moving tuple [%] with name [%] to %',
                                      current_tuple.pk,
                                      current_tuple.f_name,
                                      TG_ARGV[ 0 ];

        EXECUTE 'INSERT INTO ' || TG_ARGV[ 0 ]
                || ' SELECT $1.*'
                USING current_tuple;
    END LOOP;

    RETURN NULL;
  END
  $code$
LANGUAGE plpgsql;
