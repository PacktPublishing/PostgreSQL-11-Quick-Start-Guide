package pg11ssp;

import org.postgresql.pljava.*;
import java.util.*;
import java.sql.*;

public class TriggerCheckHash {


    public static void triggerCheckHash( TriggerData triggerData )
        throws SQLException {

        if ( ! triggerData.isFiredForEachRow()
             || ! triggerData.isFiredBefore()
             || ! ( triggerData.isFiredByInsert() || triggerData.isFiredByUpdate() ) )
            throw new TriggerException( triggerData,
                                        "This function cannot be invoked by the trigger!" );

        // get the new tuple
        ResultSet newTuple = triggerData.getNew();
        String hash = newTuple.getString( "f_hash" );

        if ( hash == null
             || hash.isEmpty() )
            throw new TriggerException( triggerData,
                                        "The hash must have a value" );

        // convert to lower case
        newTuple.updateString( "f_hash", hash.toLowerCase() );

        if ( ! hash.matches( "[abcdef0-9]{32}" ) )
            throw new TriggerException( triggerData,
                                        "Not a valid hash" );

    }

}
