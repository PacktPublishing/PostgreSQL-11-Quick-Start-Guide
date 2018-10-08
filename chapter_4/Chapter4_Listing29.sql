CREATE OR REPLACE PROCEDURE
p_insert_tags( tag_string text,
               separator text,
               max_tag_count INOUT int,
               VARIADIC tags_to_skip text[])
AS
  $code$
  DECLARE
    tag_array text[];
    current_tuple tags%rowtype;
    parent_tuple tags%rowtype;
    insert_count int := 1;
    current_skip text;
  BEGIN
    -- firs of all get all the tags
    tag_array := string_to_array( tag_string, separator );

<<TAG_LOOP>>
    FOREACH current_tuple.t_name IN ARRAY tag_array LOOP

       current_tuple.t_child_of := parent_tuple.pk;
       current_tuple.t_name     := trim( current_tuple.t_name );
       RAISE DEBUG 'Inserting tag [%] child of [%]',
                                  current_tuple.t_name,
                                  current_tuple.t_child_of;

       -- execute an insert and get back the table data
       INSERT INTO tags( t_name, t_child_of )
       VALUES ( current_tuple.t_name, current_tuple.pk )
       RETURNING *
       INTO current_tuple;


       FOREACH current_skip IN ARRAY tags_to_skip LOOP
          IF current_tuple.t_name = current_skip THEN
             -- need to skip this particular tag
             RAISE WARNING 'Aborting for tag [%]', current_tuple.t_name;
             ROLLBACK;

             -- adjust values for the next INSERT
             current_tuple := parent_tuple;
             CONTINUE TAG_LOOP;
          END IF;
       END LOOP;


       -- if here the tag should not be skipped,
       -- so commit and keep parent tuple
       IF insert_count <= max_tag_count THEN
          RAISE DEBUG 'Committing tag [%] with pk %',
                                  current_tuple.t_name,
                                  current_tuple.pk;
          COMMIT;
          parent_tuple := current_tuple;
          insert_count := insert_count + 1;
       ELSE
         RAISE WARNING 'Aborting [%], too much tags!', current_tuple.t_name;
         ROLLBACK;
         RETURN;
      END IF;

    END LOOP;

    -- feedback about committed tuples
    max_tag_count := insert_count;

  END
  $code$
LANGUAGE plpgsql;
