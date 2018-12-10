INSERT INTO files( f_name, f_hash, f_size )
SELECT 'File_' || v || '.txt',
       md5( v::text || random() ),
       v * ( random() * 111 )::int
FROM generate_series( 1, 10 ) v
RETURNING pk, f_name, f_hash, f_size, ts;
