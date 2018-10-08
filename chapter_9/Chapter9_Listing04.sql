CREATE TRIGGER tr_notify_new_music
BEFORE INSERT OR UPDATE
ON files
FOR EACH ROW
WHEN ( NEW.f_type = 'mp3' )
EXECUTE PROCEDURE f_tr_notify_new_music( 'new_music_event' );
