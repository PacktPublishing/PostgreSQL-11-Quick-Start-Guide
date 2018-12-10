package pg11ssp;

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.*;
import java.sql.*;
import java.util.logging.Logger;

public class DDLTrigger {

    @Function( name = "f_etr_avoid_drop_function_pljava",
               type = "event_trigger" )
    public static String avoidDropFunction()
        throws SQLException {
        
        ResultSet eventTuples = DriverManager
            .getConnection("jdbc:default:connection")
            .createStatement()
            .executeQuery( "SELECT * FROM pg_event_trigger_dropped_objects()" );

        if ( eventTuples.next() )
            if ( eventTuples.getString( "object_type" ).equals( "function" ) )
                throw new SQLException( "Cannot drop a function!" );

        return "";
    }
}
