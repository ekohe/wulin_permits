# WulinPermits

A flexible permissions management gem for WulinMaster applications with privilege-based access control.

## Overview

WulinPermits provides a four-tier permission system with two permission paths:

```
Users → Roles → Privileges → Permissions
Users → Privileges → Permissions (direct assignment)
```

This allows you to:
- Group related permissions into privileges
- Assign privileges to roles for hierarchical access control
- Grant privileges directly to users for fine-grained exceptions
- Inherit permissions from multiple sources (roles and direct privileges)

## Architecture

```
┌─────────┐      ┌─────────┐      ┌────────────┐      ┌─────────────┐
│  Users  │──────│  Roles  │──────│ Privileges │──────│ Permissions │
└─────────┘      └─────────┘      └────────────┘      └─────────────┘
     │                                   │
     └───────────────────────────────────┘
              (direct assignment)
```

**Join Tables:**
- `roles_users` - User to Role assignments
- `roles_privileges` - Role to Privilege assignments
- `users_privileges` - User to Privilege (direct) assignments
- `permissions_privileges` - Permission to Privilege assignments

**Database Views:**
- `user_all_permissions` - Aggregates all permissions for a user from roles and privileges
- `permission_all_users` - Aggregates all users who have a specific permission

## Core Concepts

### Permissions
The most granular level - specific actions users can perform.

**Auto-generated format:**
- `screen_name#read` - View access
- `screen_name#cud` - Create, Update, Delete access
- `controller_name#action_name` - Custom actions

**Examples:** `user#read`, `user#cud`, `reports#export`

### Privileges
Bundles of related permissions that can be assigned to roles or users directly.

**Example:** A "User Management" privilege might include `user#read`, `user#cud`, `roles_user#read`, etc.

### Roles
Named collections of privileges (e.g., Admin, Manager, Viewer). Roles provide a way to group privileges for easier assignment to multiple users.

### Users
Get permissions through:
1. Admin status (`user.admin? == true`) - bypasses all checks
2. Assigned roles (inherit all role → privilege → permissions)
3. Direct privilege assignment (privilege → permissions)

## Installation

```bash
# 1. Add to Gemfile
gem 'wulin_permits', path: 'vendor/gems/wulin_permits'

# 2. Install
bundle install

# 3. Run migrations (creates tables and views automatically)
rails db:migrate

# 4. Load permissions from screens and routes
rake wulin_permits:load_permission
```

### What the Migration Does

Running `rails db:migrate` automatically:
- Creates privilege tables (`privileges`, `roles_privileges`, `users_privileges`, `permissions_privileges`)
- Migrates existing Role/Permission data to the new Privilege model
- Creates SQL views (`user_all_permissions`, `permission_all_users`)

## Menu Configuration

Add privilege management screens to your application menu:

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

## Automatic Permission Enforcement

WulinPermits automatically protects all WulinMaster screens:

- **Admin users** bypass all checks
- **Non-admin users** must have required permission
- **Permissions auto-create** on first access
- **CUD actions** require `screen_name#cud` permission
- **Read actions** require `screen_name#read` permission

## Built-in Screens

WulinPermits provides screens for managing the permission system:

### Primary Screens
- `UserScreen` - User management
- `RoleScreen` - Role management
- `PrivilegeScreen` - Privilege management with attached permissions
- `PermissionScreen` - Permission management

### Master-Detail Screens
- `MasterUserDetailRoleScreen` - Users with their Roles
- `MasterUserDetailPrivilegeScreen` - Users with their Privileges
- `MasterUserDetailPermissionScreen` - Users with all Permissions (via view)
- `MasterRoleDetailUserScreen` - Roles with their Users
- `MasterRolePrivilegeScreen` - Roles with their Privileges
- `MasterPrivilegeDetailUserScreen` - Privileges with their Users
- `MasterPrivilegeRoleScreen` - Privileges with their Roles
- `MasterPermissionDetailUserScreen` - Permissions with all Users (via view)
- `MasterPermissionPrivilegeScreen` - Permissions with their Privileges

### Assignment Screens
- `AddRoleForUserScreen` - Attach roles to a user
- `AddUserForRoleScreen` - Attach users to a role
- `AddPrivilegeForUserScreen` - Attach privileges to a user
- `AddUserForPrivilegeScreen` - Attach users to a privilege
- `AddPrivilegeToRoleScreen` - Attach privileges to a role
- `AddRoleToPrivilegeScreen` - Attach roles to a privilege
- `AddPermissionToPrivilegeScreen` - Attach permissions to a privilege
- `AddPrivilegeToPermissionScreen` - Attach privileges to a permission

## Troubleshooting

**Users can't access screens:**
1. Check: `user.admin?`
2. Check: `Permission.find_by(name: 'screen_name#read')`
3. Check: `user.has_permission_with_name?('screen_name#read')`
4. Verify: `UserAllPermission.table_exists?`

**Permissions not auto-creating:**
- Verify controller extends `WulinMaster::ScreenController`
- Check logs for unauthorized warnings

**View not found errors:**
- Run: `rails db:migrate` (views are created by migrations)
- Check that `db/views/*.sql` files exist

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Developed by [ekohe](mailto:dev@ekohe.com) for the WulinMaster framework.
