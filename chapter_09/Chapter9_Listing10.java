import java.sql.*;
import org.postgresql.*;

class PlayListManager {
    public static void main( String argv[] )
        throws Exception {

        Class.forName( "org.postgresql.Driver" );
        String url = "jdbc:postgresql://localhost:5432/testdb";

        Connection databaseConnection = DriverManager.getConnection( url,"luca", "xxxx" );

        Statement listenCommand = databaseConnection.createStatement();
        listenCommand.execute( "LISTEN new_music_event" );
        listenCommand.close();

        while ( true ) {
            PGNotification notifications[] = databaseConnection
                .unwrap( org.postgresql.PGConnection.class )
                .getNotifications();

            if ( notifications == null || notifications.length == 0 )
                continue;

            for ( PGNotification event : notifications ){
                System.out.println( String.format( "Got event over %s from process %d payload %s",
                                                   event.getName(),
                                                   event.getPID(),
                                                   event.getParameter() ) );

                String query = String.format( "INSERT INTO playlist( p_name) SELECT f_name FROM files WHERE pk = %d", Integer.parseInt( event.getParameter() ) );

                Statement insert = databaseConnection.createStatement();
                insert.execute( query );
                insert.close();

            }

            Thread.sleep( 1000 );
        }
    }
}
