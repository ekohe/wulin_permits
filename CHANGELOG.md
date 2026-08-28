# Changelog

All notable changes to this project will be documented in this file.

### Changed - Users / Roles for non-admins

- `MasterUserDetailRoleScreen` uses standard screen permissions instead of `user.admin?`
- `UsersController` and `RolesUsersController` no longer require admin; they enforce permissions
- Invite / reset / delete stay hidden unless `users#invite`, `users#send_mail`, or `users#destroy` is granted
- Migration `CreateUserManagementPermissions` inserts the required permission names

### Added - Privilege System

Introduced a new **Privilege** concept to enhance the permissions model:

- Added `Privilege` model alongside existing `Role` model
- Added `UsersPrivilege` join table for user-privilege associations
- Added `PermissionsPrivilege` join table for permission-privilege associations
- Added privilege management screens:
  - `MasterUserDetailPrivilegeScreen` - Users / Privileges management
  - `PrivilegeScreen` - Privileges / Permissions management
  - `MasterRolePrivilegeScreen` - Roles / Privileges management

### Changed

- **Access Control Menu Structure**: Updated navigation to include privilege management:
  ```ruby
  submenu "Access Control" do
    item MasterUserDetailRoleScreen, icon: :group_add,
      reverse: c.roles_path(screen: "MasterRoleDetailUserScreen")
    item MasterUserDetailPrivilegeScreen, icon: :folder_shared,
      reverse: c.privileges_path(screen: "MasterPrivilegeDetailUserScreen")
    item MasterRolePrivilegeScreen, icon: :vpn_key,
      reverse: c.roles_path(screen: :MasterPrivilegeRoleScreen),
      label: "Roles / Privileges"
    item PrivilegeScreen, icon: :fingerprint,
      reverse: c.privileges_path(screen: :MasterPermissionPrivilegeScreen),
      label: "Privileges / Permissions"
    item MasterUserDetailPermissionScreen, icon: :lock,
      reverse: c.permissions_path(screen: "MasterPermissionDetailUserScreen"),
      label: "Permissions / Users"
    item PermissionScreen, icon: :security
  end
  ```

## Migration Guide

### 1. Data Migration (Optional - if you want to keep original data)

If you want to preserve existing roles data, create a migration script to migrate roles to privileges:

```ruby
Role.find_each do |role|
  Privilege.find_or_create_by!(id: role.id) do |privilege|
    privilege.name        = role.name
    privilege.description = role.description
    privilege.created_at  = role.created_at
    privilege.updated_at  = role.updated_at
  end
  ActiveRecord::Base.connection.reset_pk_sequence!(Privilege.table_name)
end

# Clear roles
Role.delete_all

RolesUser.find_each do |roles_user|
  UsersPrivilege.find_or_create_by!(
    user_id: roles_user.user_id,
    privilege_id: roles_user.role_id
  )
end
ActiveRecord::Base.connection.reset_pk_sequence!(UsersPrivilege.table_name)

# Clear roles_users
RolesUser.delete_all

PermissionsRole.find_each do |permissions_role|
  PermissionsPrivilege.find_or_create_by!(
    permission_id: permissions_role.permission_id,
    privilege_id: permissions_role.role_id
  )
end
ActiveRecord::Base.connection.reset_pk_sequence!(PermissionsPrivilege.table_name)

# Clear permissions_roles
PermissionsRole.delete_all

```

### 2. Database Views Required

Create two views in `db/views/` directory.

### 3. Update Menu Configuration

Update your application's menu configuration to include the new privilege-related screens as shown in the "Changed" section above.
