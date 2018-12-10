SELECT f_name, f_type, f_media_type
      FROM files
      WHERE f_media_type IN ( 'audio', 'image' );
