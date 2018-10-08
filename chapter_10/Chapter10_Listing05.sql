SELECT f_name, f_type, f_media_type
       FROM files
       WHERE f_media_type > 'audio'
         AND f_media_type < 'text';
