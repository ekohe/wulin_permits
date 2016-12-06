module WulinPermits
  module Extensions
    module ScreenController
      extend ActiveSupport::Concern

      included do |base|
        before_filter :create_permissions
      end

      def create_permissions
        return true unless respond_to?(:current_user)

        if current_user.admin?
          setup_permission
          return true
        else
          permission_verify
        end
      end

      def permission_verify
        permission = if cud?
          create_permission("#{screen.name}#cud")
        elsif read?
          create_permission("#{screen.name}#read")
        else
          create_permission("#{controller_name}##{action_name}")
        end
        return unauthorized unless current_user.has_permission?(permission) #permission.roles_users.where(user_id: current_user.id).count.zero?
      end


      private

      def setup_permission
        if cud? or read?
          create_permission("#{screen.name}#cud")
          create_permission("#{screen.name}#read")
        else
          create_permission("#{controller_name}##{action_name}")
        end
      end

      def create_permission(name)
        Permission.find_or_create_by(name: name)
      end

      def cud?
        %w(new show edit update create destroy wulin_master_new_form wulin_master_edit_form wulin_master_option_new_form).include? action_name
      end

      def read?
        action_name == 'index'
      end

    end
  end
end
