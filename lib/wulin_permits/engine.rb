require "rails"

module WulinPermits
  class Engine < Rails::Engine
    initializer "include extensions to screen controller" do |app|
      WulinMaster::ScreenController.send :include, WulinPermits::ScreenControllerExtension
      User.send(:include, WulinPermits::Helper)
    end
  end
end