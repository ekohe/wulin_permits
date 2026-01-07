CREATE OR REPLACE VIEW public.permission_all_users AS
SELECT
  CONCAT(permission_id, '-', user_id, '-', source_type) AS id,
  permission_id,
  permission_name,
  permission_description,
  user_id,
  source_type,
  source_name
FROM (
  -- Users from roles
  SELECT DISTINCT
    p.id AS permission_id,
    p.name AS permission_name,
    p.description AS permission_description,
    ru.user_id,
    'role' AS source_type,
    r.name AS source_name
  FROM roles_users ru
  INNER JOIN roles_privileges rp ON rp.role_id = ru.role_id
  INNER JOIN permissions_privileges pp ON pp.privilege_id = rp.privilege_id
  INNER JOIN permissions p ON p.id = pp.permission_id
  INNER JOIN roles r ON r.id = ru.role_id

  UNION

  -- Users from privileges
  SELECT DISTINCT
    p.id AS permission_id,
    p.name AS permission_name,
    p.description AS permission_description,
    up.user_id,
    'privilege' AS source_type,
    priv.name AS source_name
  FROM users_privileges up
  INNER JOIN permissions_privileges pp ON pp.privilege_id = up.privilege_id
  INNER JOIN permissions p ON p.id = pp.permission_id
  INNER JOIN privileges priv ON priv.id = up.privilege_id
) subquery
ORDER BY permission_name, user_id;
