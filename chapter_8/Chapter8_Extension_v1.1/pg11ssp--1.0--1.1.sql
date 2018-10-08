ALTER TABLE files ADD COLUMN note text;


CREATE OR REPLACE PROCEDURE
p_insert_tags(  text,
                text,
                max_tag_count INOUT int,
               VARIADIC  text[])
AS
  $code$

  my ( $tag_string, $separator, $max_tag_count, $tags_to_skip ) = @_;
  my ( $current_tuple, $parent_tuple, $insert_count ) = ( undef, undef, 1 );
  $insert_count    = 1;

  my $prepared_statement = spi_prepare( 'INSERT INTO tags( t_name, t_child_of )VALUES( $1, $2 ) RETURNING *',
                           'text',
                           'int' );

TAG_LOOP:
  for my $current_tag_name ( split /$separator/, $tag_string ){
      # trim the tag name
      ( $current_tuple->{ t_name }   = $current_tag_name ) =~ s/^\s+|\s+$//g;
      $current_tuple->{ t_child_of } = $parent_tuple->{ pk } if ( defined $parent_tuple );
      elog( DEBUG,
      "Building tuple for [$current_tuple->{ t_name }] child of [$current_tuple->{ t_child_of }]" );


      # build up the query
      my $result_set = spi_exec_prepared( $prepared_statement,
                                          $current_tuple->{ t_name },
                                          $current_tuple->{ t_child_of } );

      if ( $result_set->{ status } == SPI_OK_INSERT_RETURNING ) {
         $current_tuple = $result_set->{ rows }[ 0 ];
     }


     # skip bad tags
     if ( grep( /$current_tuple->{ t_name}/, @$tags_to_skip ) ){
        elog( WARNING, "Aborting for tag $current_tuple->{ t_name }" );
        spi_exec_query( "ROLLBACK" );
        $current_tuple = $parent_tuple;
        next TAG_LOOP;
     }

     if ( $insert_count <= $max_tag_count ){
        elog( DEBUG, "Committing tag [$current_tuple->{ t_name }] with pk $current_tuple->{ pk }" );
        spi_exec_query( "COMMIT" );
        $parent_tuple = $current_tuple;
        $insert_count++;
     }
     else {
          elog( WARNING, "Aborting [$current_tuple->{ t_name }], too much tags!" );
          spi_exec_query( "ROLLBACK" );
          return { max_tag_count => $insert_count };
     }
     
  }

  return { max_tag_count => $insert_count };
  $code$
LANGUAGE plperl;
