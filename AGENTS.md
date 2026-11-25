# AGENTS.md

`wulin_permits` is a Rails engine for roles, privileges and permissions. It always loads into a host app next to `wulin_master`. Host apps: ceres, atlas, cruise, olatu, mima, bss, bss_ofe, mrl, waldo, xixi and ekohe-backoffice, each as the `vendor/gems/wulin_permits` submodule.

## Wiring it into a host app

The README Installation section lists the steps: the `Gemfile` path entry, `rails db:migrate`, `rake wulin_permits:load_permission`, the JS import in `app/javascript/application.js`, and the menu items. An engine cannot add menu items, so each app declares them in its menu.

## Gotchas

- The engine includes its extensions when the host app prepares: `WulinPermits::Extensions::User` into `User` (or `WulinAuth::User`, or `WulinOAuth::User` when `User` is not defined), `ScreenController` into `WulinMaster::ScreenController`, and `Screen` into `WulinMaster::Screen` (`lib/wulin_permits/engine.rb`).
- The `append_migrations` initializer adds the gem's `db/migrate` to the host app. Run `rails db:migrate` in the host after every submodule bump that adds a migration.
- `db/views/*.sql` back the `user_all_permissions` and `permission_all_users` views. Hosts that share one database (ceres, atlas, cruise, olatu) drop and recreate views on every deploy.
- `config/routes.rb` draws into `Rails.application.routes`. The engine is not mounted.
- Screens, grids and models are top-level constants, not under `WulinPermits::`.
- Admins (`user.admin?`) skip every check. Test with a non-admin user to see missing permissions.
- Permissions are created on first access. The read and cud permission names come from the screen name: `ExampleScreen` becomes `example#read` and `example#cud`. Other actions use `<controller>#<action>`.
- `UserManagement::PERMISSIONS` in `lib/wulin_permits/user_management.rb` lists the permissions that the Users / Roles screens need for non-admin users.
- `user.has_permission?` reads the `UserAllPermission` view. Without it, the method logs an error and falls back to direct queries.
- The rake task `wulin_permits:load_permission` exists only when `WulinMaster` is defined.

## Commands

The gem has no test suite. CI builds the gem. Use Ruby 4.0.10.

```bash
bundle install
gem build wulin_permits.gemspec
```

`bundle install` needs SSH access to `gitlab.ekohe.com`, because `wulin_master` comes from its `v3` branch in the `Gemfile`.

To verify behavior, run a host app that vendors this gem, such as ceres, and test the screens as a non-admin user.
