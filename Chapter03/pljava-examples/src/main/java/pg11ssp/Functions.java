package pg11ssp;

import org.postgresql.pljava.*;
import java.util.logging.Logger;
import java.util.*;

public class Functions {

    public static Iterator<String> splitTagString ( String tagString, String delimiter ){
        Logger logger = Logger.getAnonymousLogger();

        // set a default value for the delimiter
        if ( delimiter == null || delimiter.isEmpty() )
            delimiter = ">";

        logger.info( "Splitting tag string [" + tagString + "] with [" + delimiter + "]" );
        List<String> tags = new ArrayList<String>();
	for ( String currentTag : tagString.split( delimiter ) )
	    tags.add( currentTag.trim() );

        return tags.iterator();
    }
}
