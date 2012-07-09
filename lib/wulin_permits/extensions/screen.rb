module WulinPermits
  module Extensions
    module Screen
      extend ActiveSupport::Concern
      
      included do |base|
        class_eval do
          def authorized?(user)
            @authorized ||= {}
            @authorized[user] ||= begin
              permission = Permission.find_or_create_by_name("#{name}#read")
              return true if user.respond_to?(:admin?) && user.admin?
              user.has_permission?(permission)
            end
          end

          def authorize_create?(user)
            @authorize_create ||= {}
            @authorize_create[user] ||= begin
              permission = Permission.find_or_create_by_name("#{name}#cud")
              return true if user.respond_to?(:admin?) && user.admin?
              user.has_permission?(permission)
            end
          end
          alias_method :authorize_update?, :authorize_create?
          alias_method :authorize_destroy?, :authorize_create?
        end

      end
      
    end
  end
end

