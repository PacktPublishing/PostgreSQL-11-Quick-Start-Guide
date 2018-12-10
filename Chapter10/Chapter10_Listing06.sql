ALTER TYPE t_media_file_type
ADD VALUE
IF NOT EXISTS   -- optional
'pdf'           -- the new label
AFTER 'image';  -- optional
