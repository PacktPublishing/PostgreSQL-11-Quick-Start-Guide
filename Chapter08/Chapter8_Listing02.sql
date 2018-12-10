SELECT extname
       , extnamespace::regclass AS namespace
       , extversion AS version
       , CASE extrelocatable WHEN true THEN 'RELOCATABLE'
                                       ELSE 'NOT-RELOCATABLE'
        END AS relocatable_status
      , c.description AS comment
FROM pg_extension LEFT JOIN pg_description c
     ON c.objoid = oid
ORDER BY 1, 3;
