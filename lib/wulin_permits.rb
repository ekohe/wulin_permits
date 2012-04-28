require "wulin_permits/version"
require 'wulin_permits/engine' if defined?(Rails)

module WulinPermits
  # Define admin email for your app with +WulinPermits.admin=+
  # Create a file localed config/initializers/wulin_permits.rb
  # and define admin like:
  #
  # config/initializers/wulin_permits.rb:
  #
  #   WulinPermits.admin = 'admin@example.com'
  # 
  # get defined roles like:
  # 
  #   WulinPermits.admin    #=>   admin@example.com
  #
  
  def admin
    @@admin ||= ''
  end
  
  def admin=(email)
    raise 'Roles must be an array instance' unless String === email
    @@admin = email
  end
  
  module_function :admin, :admin=
end

require 'wulin_permits/extensions/screen'
