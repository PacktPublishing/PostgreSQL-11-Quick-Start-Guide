SELECT relname,
                CASE relhastriggers
                WHEN true THEN 'with triggers!'
                ELSE 'without triggers'
                END
        FROM pg_class
        WHERE relname IN ('files', 'tags' );

