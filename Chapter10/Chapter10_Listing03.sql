UPDATE files
SET f_media_type = CASE f_type
                        WHEN 'png' THEN 'image'
                        WHEN 'mp3' THEN 'audio'
                        ELSE 'text'
                        END::t_media_file_type;
