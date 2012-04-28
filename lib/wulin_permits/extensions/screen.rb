module WulinPermits
  module Extensions
    module Screen
      extend ActiveSupport::Concern
      
      included do |base|
        extend ActiveSupport::Memoizable

        class_eval do
          def authorized?(user)
            permission = Permission.find_or_create_by_name("#{name}#read")
            user.has_permission?(permission)
          end

          def authorize_create?(user)
            permission = Permission.find_or_create_by_name("#{name}#cud")
            user.has_permission?(permission)
          end
          alias_method :authorize_update?, :authorize_create?
          alias_method :authorize_destroy?, :authorize_create?
          
          memoize :authorized?, :authorize_create?
        end

      end
      
    end
  end
end


WulinMaster::Screen.send :include, WulinPermits::Extensions::Screen

