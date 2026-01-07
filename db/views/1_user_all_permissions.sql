CREATE OR REPLACE VIEW public.user_all_permissions AS
SELECT
  CONCAT(user_id, '-', permission_id, '-', source_type) AS id,
  user_id,
  permission_id,
  permission_name,
  permission_description,
  source_type,
  source_name
FROM (
  -- Permissions from roles
  SELECT DISTINCT
    ru.user_id,
    p.id AS permission_id,
    p.name AS permission_name,
    p.description AS permission_description,
    'role' AS source_type,
    r.name AS source_name
  FROM roles_users ru
  INNER JOIN roles_privileges rp ON rp.role_id = ru.role_id
  INNER JOIN permissions_privileges pp ON pp.privilege_id = rp.privilege_id
  INNER JOIN permissions p ON p.id = pp.permission_id
  INNER JOIN roles r ON r.id = ru.role_id

  UNION

  -- Permissions from privileges
  SELECT DISTINCT
    up.user_id,
    p.id AS permission_id,
    p.name AS permission_name,
    p.description AS permission_description,
    'privilege' AS source_type,
    priv.name AS source_name
  FROM users_privileges up
  INNER JOIN permissions_privileges pp ON pp.privilege_id = up.privilege_id
  INNER JOIN permissions p ON p.id = pp.permission_id
  INNER JOIN privileges priv ON priv.id = up.privilege_id
) subquery
ORDER BY user_id, permission_name;