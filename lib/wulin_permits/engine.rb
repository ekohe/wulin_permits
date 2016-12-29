require "rails"
require 'wulin_permits/extensions/user'
require 'wulin_permits/extensions/screen_controller'
require 'wulin_permits/extensions/screen'


module WulinPermits
  class Engine < Rails::Engine
    initializer "Load extensions and definations" do |app|
      User.send :include, WulinPermits::Extensions::User
      WulinMaster::ScreenController.send :include, WulinPermits::Extensions::ScreenController
      WulinMaster::Screen.send :include, WulinPermits::Extensions::Screen

      WulinMaster::add_stylesheet 'role_screen.css' unless WulinMaster::stylesheets.include? 'role_screen.css'
      WulinMaster::add_javascript 'wulin_permits.js' unless WulinMaster::javascripts.include? 'wulin_permits.js'
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
