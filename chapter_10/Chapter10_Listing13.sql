SELECT
  a.attname AS attribute_name
  , format_type( a.atttypid, a.atttypmod ) AS attribute_type
  FROM pg_attribute a
       JOIN pg_class c ON c.oid = a.attrelid
       JOIN pg_type t ON t.oid = c.reltype
  WHERE t.typname = 't_repository'::name
  AND   t.typtype = 'c'
  AND   c.relkind = t.typtype;
