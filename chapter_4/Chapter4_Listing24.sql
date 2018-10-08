CREATE OR REPLACE FUNCTION
f_insert_tags( tag_string text, separator text DEFAULT '>' )
RETURNS SETOF tags        -- returns the inserted tuples
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

       -- did the INSERT succeeded?
       IF FOUND THEN
          -- ok, append the inserted tuple to the result set
          RETURN NEXT current_tuple;
       ELSE
          -- an error occurred
          RAISE EXCEPTION 'Cannot insert tag [%] as child of [%]',
                                                   current_tuple.t_name,
                                                   current_tuple.t_child_of;
       END IF;
    END LOOP;

    -- all done
    RETURN;
  END
  $code$
LANGUAGE plpgsql
STRICT      -- returns null on null input!
VOLATILE;   -- changes the database status!
