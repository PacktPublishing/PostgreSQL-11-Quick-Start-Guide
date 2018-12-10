CREATE OR REPLACE PROCEDURE
p_insert_tags( tag_string text,
               separator text DEFAULT '>' )
AS
  $code$
  DECLARE
    tag_array text[];
    current_tuple tags%rowtype;
  BEGIN
    -- firs of all get all the tags
    tag_array := string_to_array( tag_string, separator );

    FOREACH current_tuple.t_name IN ARRAY tag_array LOOP

       current_tuple.t_child_of := current_tuple.pk;
       current_tuple.t_name     := trim( current_tuple.t_name );
       RAISE DEBUG 'Inserting tag [%] child of [%]',
                                  current_tuple.t_name,
                                  current_tuple.t_child_of;

       -- execute an insert and get back the table data
       INSERT INTO tags( t_name, t_child_of )
       VALUES ( current_tuple.t_name, current_tuple.pk )
       RETURNING *
       INTO current_tuple;

       RAISE DEBUG 'Committing [%]', current_tuple.t_name;
       COMMIT;

    END LOOP;
  END
  $code$
LANGUAGE plpgsql;
