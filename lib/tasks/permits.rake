if defined? WulinMaster
  namespace :wulin_permits do
    desc "Load all screens and actions to permits table"
    task :load_permissions => :environment do
      Dir.glob(File.join(Rails.root, "app", "screens", "*.rb")).map &method(:require) if Rails.env != 'production'
      
      WulinMaster::Screen.screens.each do |screen|
        screen_name = screen.name.sub(/Screen$/, "").underscore
        Permission.find_or_create_by_name("#{screen_name}#cud")
        Permission.find_or_create_by_name("#{screen_name}#read")
        print "."
      end
      puts ""
    end
  end
  
end