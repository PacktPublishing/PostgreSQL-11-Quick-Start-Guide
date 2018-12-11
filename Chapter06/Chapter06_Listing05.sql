SELECT tgname, tgrelid::regclass, proname
FROM pg_trigger JOIN pg_proc ON tgfoid = pg_proc.oid
WHERE tgrelid = 'files'::regclass AND tgisinternal = false;
