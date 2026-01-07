module WulinPermits
  module Extensions
    module User
      extend ActiveSupport::Concern

      def has_permission?(permission)
        @has_permission ||= {}
        @has_permission[permission] ||= begin
          if self.respond_to?(:admin?) && self.admin?
            true
          else
            # Try to use the user_all_permissions view if it exists
            if defined?(UserAllPermission) && UserAllPermission.table_exists?
              UserAllPermission.exists?(user_id: self.id, permission_id: permission.id)
            else
              Rails.logger.error("[CRITICAL] UserAllPermission view does not exist. Falling back to direct queries. Please run migrations.")
              # Fallback: check permissions from both roles and privileges
              has_permission_from_role = permission.roles_users.exists?(user_id: self.id)

              privilege_ids = permission.permissions_privileges.pluck(:privilege_id)
              has_permission_from_privilege = UsersPrivilege.exists?(user_id: self.id, privilege_id: privilege_ids)

              has_permission_from_role || has_permission_from_privilege
            end
          end
        end
      end

      def has_permission_with_name?(permission_name)
        @has_permission_with_name ||= {}
        @has_permission_with_name[permission_name] ||= begin
          if self.respond_to?(:admin?) && self.admin?
            true
          else
            has_permission?(Permission.find_or_create_by(name: permission_name))
          end
        end
      end

      def method_missing(method_name, *args, &block)
        if method_name =~ /(.*)\?$/ and args.blank?
          #self.class.send(:define_method, method_name, proc { RolesUser.user_has_role?(self, role) } )
          if (role = (Role.find_by_name($1) || Role.find_by_name($1.titleize)))
            RolesUser.user_has_role?(self, role)
          else
            false
          end
        else
          super(method_name, *args, &block)
        end
      end

    end
  end
end
