CREATE TRIGGER
tr_add_music_tag
AFTER INSERT 
ON files
FOR EACH ROW
WHEN ( NEW.f_type = 'mp3' )
EXECUTE PROCEDURE f_tr_add_music_tag( 'music' );
