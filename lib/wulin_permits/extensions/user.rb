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
            !permission.roles_users.where(user_id: self.id).count.zero?
          end
        end
      end
      
      def has_permission_with_name?(permission_name)
        @has_permission_with_name ||= {}
        @has_permission_with_name[permission_name] ||= begin
          if self.respond_to?(:admin?) && self.admin?
            true
          else
            has_permission?(Permission.find_or_create_by_name(permission_name))
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