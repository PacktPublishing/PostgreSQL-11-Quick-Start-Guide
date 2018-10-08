CREATE OR REPLACE RULE
r_append_to_playlist
AS ON INSERT
TO files
WHERE ( NEW.f_type = 'mp3' )
DO ALSO
   INSERT INTO playlist( p_name )
   VALUES ( NEW.f_name );

