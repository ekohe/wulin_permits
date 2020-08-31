require "rails"
require 'wulin_permits/extensions/user'
require 'wulin_permits/extensions/screen_controller'
require 'wulin_permits/extensions/screen'

module WulinPermits
  class Engine < Rails::Engine
    initializer "Load extensions and definitions" do |app|
      if Object.const_defined?('User')
        User.send :include, WulinPermits::Extensions::User
      elsif Object.const_defined?('WulinAuth')
        WulinAuth::User.send :include, WulinPermits::Extensions::User
      elsif Object.const_defined?('WulinOAuth')
        WulinOAuth::User.send :include, WulinPermits::Extensions::User
      end

      WulinMaster::ScreenController.send :include, WulinPermits::Extensions::ScreenController
      WulinMaster::Screen.send :include, WulinPermits::Extensions::Screen

      app.config.assets.precompile += %w(role_screen.css wulin_permits.js)
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
  end
end
