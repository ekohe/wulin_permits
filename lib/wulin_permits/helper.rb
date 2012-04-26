module WulinPermits
  module Helper
    extend ActiveSupport::Concern
  
    included do |base|
      extend ActiveSupport::Memoizable

      class_eval do
        # Override the existing +admin?+ method
        def admin?
          return true if self.email == WulinPermits.admin

          role = Role.find_by_name('admin')
          UserRole.where(user_id: self.id).pluck(:role).uniq.include?(role.id)
        end
        memoize :admin?
      end
      
    end
    
    def method_missing(method_name, *args, &block)
      if method_name =~ /(.*)\?$/ and (role = Role.find_by_name($1)) and args.blank?
        self.class.send(:define_method, method_name, proc { UserRole.where(user_id: self.id).pluck(:role).uniq.include?(role.id) } )
        
        self.class.memoize method_name.to_sym # Cache it
      else
        super(method_name, *args, &block)
      end
    end

  end
end