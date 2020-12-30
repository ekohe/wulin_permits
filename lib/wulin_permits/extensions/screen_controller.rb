module WulinPermits
  module Extensions
    module ScreenController
      extend ActiveSupport::Concern

      CUD_ACTIONS  = %w[new show edit update create destroy wulin_master_new_form wulin_master_edit_form].freeze
      READ_ACTIONS = %w[index].freeze

      included do
        # If the callback renders or redirects, the action will not run. If there are additional callbacks scheduled to run after that callback, they are also cancelled.
        before_action :create_permissions
      end

      #
      # the method will call unauthorized if user don't have the permission
      #
      def create_permissions
        return unless respond_to?(:current_user)

        # return true if we don't have the
        return if current_user.admin?

        permission_verify
      end

      #
      # we need to check the if we have the current_user
      #
      def permission_verify
        if current_user.has_permission? wulin_permits_required_permission
          # do nothing
        else
          # call the unauthorized, the unauthorized method belongs to lib/wulin_master/authorization.rb
          unauthorized
        end
      end

      #
      # the cud means create/update/delete
      #
      def cud?
        CUD_ACTIONS.include? action_name
      end

      #
      # the read? method for checking the action is read or not
      #
      def read?
        READ_ACTIONS.include? action_name
      end

      def wulin_permits_required_permission
        @wulin_permits_required_permission ||= setup_missing_permission
      end

      private

      def setup_missing_permission
        screen_name = screen.name.sub(/Screen$/, "").underscore

        if cud?
          create_permission [screen_name, :cud].join("#")
        elsif read?
          create_permission [screen_name, :read].join("#")
        else
          create_permission [controller_name, action_name].join("#")
        end
      end

      def create_permission(name)
        Permission.where(name: name).first_or_create
      end
    end
  end
end
