CREATE OR REPLACE PROCEDURE
p_tx_action( what int DEFAULT 0 )
AS
  $code$
  BEGIN
    IF what = 0 THEN
       RAISE DEBUG 'doing nothing!';
    ELSIF what = 1 THEN
       RAISE DEBUG 'Issuing a commit!';
       COMMIT;
    ELSE
       RAISE DEBUG 'Issuing a rollback';
       ROLLBACK;
    END IF;
  END
  $code$
LANGUAGE plpgsql;
