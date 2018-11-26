class returning {
    public static void main( String argv[] ) throws Exception {
        Class.forName( "org.postgresql.Driver" );
        String connectionURL = "jdbc:postgresql://localhost/testdb";
        Properties connectionProperties = new Properties();
        connectionProperties.put( "user", "luca" );
        connectionProperties.put( "password", "xxxx" );
        Connection conn = DriverManager.getConnection( connectionURL, connectionProperties );

        String query = "INSERT INTO files( f_name, f_hash, f_size ) "
            + " SELECT 'file_' || v || '.txt',"
            + " md5( v::text ),"
            + " v * ( random() * 100 )::int"
            + " FROM generate_series(1, 10 ) v "
            + " RETURNING pk, f_name, f_hash, f_size, ts;";

        Statement statement = conn.createStatement();
        ResultSet resultSet = statement.executeQuery( query );
        while ( resultSet.next() )
            System.out.println( String.format( "pk = %d, size = %d, hash = %s",
                                               resultSet.getLong( "pk" ),
                                               resultSet.getInt( "f_size" ),
                                               resultSet.getString( "f_hash" ) ) );

        resultSet.close();
        statement.close();
    }
}
