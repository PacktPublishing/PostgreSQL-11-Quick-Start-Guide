CREATE OR REPLACE RULE
r_delete_mp3
AS ON DELETE
TO files
WHERE ( OLD.f_type = 'mp3' )
DO ALSO
   DELETE FROM playlist
   WHERE p_name = OLD.f_name;


