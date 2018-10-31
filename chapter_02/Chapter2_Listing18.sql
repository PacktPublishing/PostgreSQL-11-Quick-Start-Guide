WITH RECURSIVE tags_tree AS (
  -- non recursive statment
  SELECT t_name, pk
  FROM tags
  WHERE t_child_of IS NULL

  UNION

  -- recursive statement
  SELECT tt.t_name || ' > ' || ct.t_name, ct.pk
  FROM tags ct
  JOIN tags_tree tt ON tt.pk = ct.t_child_of
)

SELECT t_name
FROM tags_tree
ORDER BY t_name;
