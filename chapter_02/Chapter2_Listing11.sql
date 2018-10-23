WITH
  get_current_time  AS ( SELECT now()::time )
, get_random_number AS ( SELECT random() )
, delete_files      AS ( DELETE FROM files )

SELECT r, s
FROM get_random_number r
     generate_series( 1, 3 ) s;
