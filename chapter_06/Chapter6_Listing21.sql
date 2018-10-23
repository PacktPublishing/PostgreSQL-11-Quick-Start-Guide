CREATE OR REPLACE FUNCTION
f_tr_add_music_tag()
RETURNS TRIGGER
AS
  $code$
  BEGIN
    INSERT INTO j_files_tags( f_pk, t_pk )
    SELECT NEW.pk, t.pk
    FROM   tags t
    WHERE  t.t_name = TG_ARGV[ 0 ];

    RETURN NEW;
  END

  $code$
LANGUAGE plpgsql;
