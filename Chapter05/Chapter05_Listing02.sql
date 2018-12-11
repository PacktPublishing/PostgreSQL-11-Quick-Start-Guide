DO LANGUAGE plperl
$code$
  my $query = sprintf "SELECT f_name, f_hash FROM files";
  my $result_set = spi_exec_query( $query );

  # did the query run ok?
  elog( EXCEPTION, "Query failed!" ) if ( $result_set->{ status } != SPI_OK_SELECT );

  for my $i ( 0 .. $result_set->{ processed } - 1 ){
      my $tuple = $result_set->{ rows }[ $i ];
      my $file_name = $tuple->{ f_name };
      my $file_hash = $tuple->{ f_has };

      elog( DEBUG, "Row $i holds file $file_name with hash $file_hash" );
  }
$code$;
