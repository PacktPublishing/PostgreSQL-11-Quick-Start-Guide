CREATE OR REPLACE FUNCTION
f_tr_notify_new_music()
RETURNS TRIGGER
AS
  $code$
  BEGIN

    IF NEW.f_type = 'mp3' THEN
        RAISE DEBUG 'Notifying new primary key % over channel %',
                    NEW.pk,
                    TG_ARGV[ 0 ];

       PERFORM pg_notify( TG_ARGV[ 0 ], -- channel name
                         NEW.pk::text );
    END IF;

    RETURN NEW;
  END
  $code$
LANGUAGE plpgsql;
