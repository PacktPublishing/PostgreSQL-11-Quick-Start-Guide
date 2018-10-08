CREATE OR REPLACE RULE
r_archive_tuples_on_deletion
AS ON DELETE
TO files
DO ALSO
INSERT INTO archive_files
SELECT OLD.*;
