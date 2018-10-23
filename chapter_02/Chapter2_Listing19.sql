WITH RECURSIVE tags_tree AS (
  -- non recursive statment
  SELECT t_name, pk, 1 AS level
  FROM tags
  WHERE t_child_of IS NULL

  UNION

  -- recursive statement
  SELECT tt.t_name || ' > ' || ct.t_name, ct.pk
        , tt.level + 1
  FROM tags ct
  JOIN tags_tree tt ON tt.pk = ct.t_child_of
)

SELECT name
FROM tags_tree
WHERE t_name like '%2018%'
AND level > 1;
