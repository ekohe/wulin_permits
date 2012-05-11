module WulinPermits
  module Extensions
    module User
      extend ActiveSupport::Concern

      included do |base|

        class_eval do
          # Override the existing +admin?+ method
          def admin?
            @admin ||= begin
              return true if self.email == WulinPermits.admin

              role = Role.find_by_name('admin')
              UserRole.user_has_role?(self, role)
            end
          end
          
          def has_permission?(permission)
            @has_permission ||= {}
            @has_permission[permission] ||= begin
              return true if self.email == WulinPermits.admin
              !permission.user_roles.where(user_id: self.id).count.zero?
            end
          end
          
          def has_permission_with_name?(permission_name)
            @has_permission_with_name ||= {}
            @has_permission_with_name[permission_name] ||= begin
              return true if self.email == WulinPermits.admin
              has_permission?(Permission.find_or_create_by_name(permission_name))
            end
          end
        end

      end

      def method_missing(method_name, *args, &block)
        if method_name =~ /(.*)\?$/ and (role = Role.find_by_name($1)) and args.blank?
          self.class.send(:define_method, method_name, proc { UserRole.user_has_role?(self, role) } )
        else
          super(method_name, *args, &block)
        end
      end

    end
  end
end