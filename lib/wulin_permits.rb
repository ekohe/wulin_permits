require "wulin_permits/version"
require 'wulin_permits/engine' if defined?(Rails)

module WulinPermits
  # Define roles for your app with +WulinPermits.roles=+
  # Create a file localed config/initializers/wulin_permits.rb
  # and define roles like:
  #
  # config/initializers/wulin_permits.rb:
  #
  #   WulinPermits.roles = [:operator, :manager, :admin]
  # 
  # get defined roles like:
  # 
  #   WulinPermits.roles    #=>   [:operator, :manager, :admin]
  #
  
  def roles
    @@roles ||= []
  end
  
  def roles=(roles)
    raise 'Roles must be an array instance' unless Array === roles
    @@roles = roles
  end
  
  module_function :roles, :roles=
  
end

require 'wulin_permits/helper'
