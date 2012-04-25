module WulinPermits
  module Helper
    extend ActiveSupport::Concern
    
    def method_missing(method_name, *args, &block)
      if method_name =~ /(.*)\?$/ and (role = Role.find_by_name($1)) and args.blank?
        UserRole.where(user_id: self.id).map(&:role).include? role.id
      else
        super(method_name, *args, &block)
      end
    end

  end
end