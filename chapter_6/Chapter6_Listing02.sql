CREATE TRIGGER tr_notifier
BEFORE                             -- timing
INSERT OR UPDATE OR DELETE         -- event
ON files                           -- table
FOR EACH ROW                       -- level
EXECUTE PROCEDURE f_tr_notifier(); -- trigger function
