module WulinPermits
  module Helper
    extend ActiveSupport::Concern
    
    included do |base|
      WulinPermits.roles.each do |role|
        base.class_eval <<-METHOD, __FILE__, __LINE__ + 1
          def #{role.to_s}?                                    # def admin?
            has_role?(:#{role})                                 #   has_role?(:admin)
          end                                                  # end
        METHOD
      end
    end
    
    def user_roles
      UserRole.where(:user_id => id)
    end
    
    def has_role?(role)
      user_roles.map(&:role).include?(WulinPermits.roles.index(role))
    end
    
  end
end