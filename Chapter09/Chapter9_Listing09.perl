#!env perl

use v5.20;

use DBI;

my $database_connection =
    DBI->connect( 'dbi:Pg:dbname=testdb host=localhost', 'luca', 'xxxxx' )
    || die "\nCannot connect to database \n$!";

# subscribe to the channel
$database_connection->do( 'LISTEN new_music_event' );

while ( 1 ) {
    while ( my $event = $database_connection->func( 'pg_notifies' ) ){
        my ( $name, $pid, $payload ) = @$event;
        say "Received an event over $name from process $pid with payload $payload";

        # add the new song to the playlist
        my $query = sprintf 'INSERT INTO playlist( p_name ) SELECT f_name FROM files WHERE pk = %d' , $payload;
        $database_connection->do( $query );

        sleep 1;
    }
}

