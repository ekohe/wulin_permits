module WulinPermits
  module Extensions
    module Screen
      extend ActiveSupport::Concern

      included do
        def authorized?(user = nil)
          user ||= current_user
          return false if user.blank?

          @authorized ||= {}
          return @authorized[user.email] if @authorized.key?(user.email)

          @authorized[user.email] = authorized_for_user_and_permission?(user, get_permission_name(:read))
        end

        def authorize_create?(user = nil)
          user ||= current_user
          return false if user.blank?

          @authorize_create ||= {}
          return @authorize_create[user.email] if @authorize_create.key?(user.email)

          @authorize_create[user.email] = authorized_for_user_and_permission?(user, get_permission_name(:cud))
        end

        # get the permission name
        def get_permission_name(action)
          # permits.rake
          screen_name = name.sub(/Screen$/, '').underscore
          [screen_name, action].join('#')
        end

        alias_method :authorize_update?, :authorize_create?
        alias_method :authorize_destroy?, :authorize_create?

        private

        def authorized_for_user_and_permission?(user, permission_name)
          if user.respond_to?(:admin?) && user.admin?
            true
          else
            user.has_permission?(Permission.find_or_create_by(name: permission_name))
          end
        end
      end
    end
  end
end
