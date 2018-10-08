SELECT f_name, f_human_file_size( f_size )
         FROM f_fake_files( 3 );

f_name | f_human_file_size
--------+-------------------
File_1 | 146713.36bytes
File_2 | 590618.06bytes
File_3 | 1.38KB
