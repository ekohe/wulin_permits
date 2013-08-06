module WulinPermits
  module Extensions
    module Screen
      extend ActiveSupport::Concern
      
      included do
        class_eval do

          def authorized?(user)
            @authorized ||= {}
            @authorized[user] ||= authorized_for_user_and_permission?(user, "#{name}#read")
          end

          def authorize_create?(user)
            @authorize_create ||= {}
            @authorize_create[user.email] ||= authorized_for_user_and_permission?(user, "#{name}#cud")
          end

          alias_method :authorize_update?, :authorize_create?
          alias_method :authorize_destroy?, :authorize_create?

          private
            def authorized_for_user_and_permission?(user, permission)
              if user.respond_to?(:admin?) && user.admin?
                true
              else
                user.has_permission?(Permission.find_or_create_by_name(permission))
              end
            end
        end

      end
      
    end
  end
end

