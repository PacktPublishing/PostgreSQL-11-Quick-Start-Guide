package pg11ssp;

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.*;
import java.util.logging.Logger;
import java.util.*;
import java.io.*;
import java.sql.*;
import java.security.MessageDigest;
import java.nio.file.*;

public class FileTupleBuilder implements ResultSetProvider {

	private List<File> files = new ArrayList<File>();
	private static Logger logger = Logger.getAnonymousLogger();

	public boolean assignRowValues( ResultSet currentTuple, int currentRow )
			throws SQLException {

		if ( files.isEmpty() || currentRow >= files.size() )
			return false;

		File currentFile = files.get( currentRow );
		logger.info( "File " + currentFile.getPath() + " at tuple number " + currentRow );

		/* update some fields on this tuple */
		currentTuple.updateString( "f_name", currentFile.getName() );
		currentTuple.updateLong( "f_size", currentFile.length() );
		currentTuple.updateTimestamp( "ts", new Timestamp( System.currentTimeMillis() ) );

		/* get the sequence next value */
		ResultSet resultSet = DriverManager
				.getConnection("jdbc:default:connection")
				.createStatement()
				.executeQuery( "SELECT nextval( 'files_pk_seq' )" );
		if ( resultSet.next() )
			currentTuple.updateInt( "pk", resultSet.getInt( 1 ) );
		else
			throw new SQLException( "Cannot get primary key value from sequence" );

		/* compute the type of the file from its extension */
		int extensionIndex = currentFile.getName().lastIndexOf( "." );
		if ( extensionIndex > 0 )
			currentTuple.updateString( "f_type", currentFile.getName().substring( extensionIndex + 1 ) );
		else
			currentTuple.updateString( "f_type", "txt" );

		/* compute the hash of the file */
		try{
			MessageDigest digestEngine = MessageDigest.getInstance("SHA-1");
			StringBuffer sha1String = new StringBuffer();
			if (digestEngine != null) {
				byte[] sha1 = digestEngine.digest( Files.readAllBytes( Paths.get( currentFile.getAbsolutePath() ) ) );

				for (byte b : sha1)
					sha1String.append( String.format("%02x", b) );
			}

			currentTuple.updateString( "f_hash", sha1String.toString() );

		} catch ( Exception e ){
			logger.warning( "Cannot compute the hash" );
			currentTuple.updateString( "f_hash", "n/a" );
		}

		// add this tuple to the result set
		return true;
	}


	public void close(){}


	@Function( type = "files",
			name = "f_j_files_from_directory",
			trust = Function.Trust.UNSANDBOXED, // untrusted
			effects = Function.Effects.VOLATILE,
			onNullInput = Function.OnNullInput.RETURNS_NULL // strict
			)
	public static ResultSetProvider scanDirAndBuildTuples( String dir ) throws SQLException {

		FileTupleBuilder tupleBuilder = new FileTupleBuilder();

		try {

			File dirHandle = new File( dir );
			if ( ! dirHandle.isDirectory() )
				throw new SQLException( "Not a directory" );

			for ( File currentEntry : dirHandle.listFiles() ){
				if ( ! currentEntry.isFile() )
					continue;

				logger.info( "Building tuple for file " + currentEntry.getPath() );

				tupleBuilder.files.add( currentEntry );

			}

			return tupleBuilder;

		} catch ( Exception e ){
			logger.warning( "Cannot scan directory " + dir );
			throw new SQLException( e );
		}
	}
}
