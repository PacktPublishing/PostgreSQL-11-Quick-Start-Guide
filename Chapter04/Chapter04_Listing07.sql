CREATE OR REPLACE FUNCTION
f_human_file_size( f_size numeric )
RETURNS text
AS
 $code$
    DECLARE
        size_kb CONSTANT int    := 1024 * 1024;
        size_mb CONSTANT bigint := size_kb * 1024;
        size_gb CONSTANT bigint := size_mb * 1024;
        unit text := 'bytes';
    BEGIN
      IF f_size > size_gb THEN
         f_size := f_size / size_gb;
         unit   := 'MB';
      ELSEIF f_size > size_mb THEN
         f_size := f_size / size_mb;
         unit   := 'MB';
     ELSEIF f_size > size_kb THEN
         f_size := f_size / size_kb;
         unit   := 'KB';
     ELSE
        unit := 'bytes';
     END IF;

     RETURN round( f_size, 2 ) || unit;
    END
 $code$
LANGUAGE plpgsql;
