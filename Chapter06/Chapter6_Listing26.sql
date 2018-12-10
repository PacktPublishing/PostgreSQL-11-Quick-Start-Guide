CREATE EVENT TRIGGER
etr_notifier
ON sql_drop
EXECUTE PROCEDURE f_etr_notifier();
