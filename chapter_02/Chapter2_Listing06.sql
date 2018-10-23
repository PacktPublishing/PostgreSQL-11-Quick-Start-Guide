INSERT INTO files( f_name, f_hash, f_size )
SELECT 'file_' || v || '.txt',
md5( v::text ),
v * ( random() * 100 )::int
FROM generate_series(1, 10 ) v;
