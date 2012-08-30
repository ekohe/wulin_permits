if defined? WulinMaster
  namespace :wulin_permits do
    
    # desc "Load all screens and actions to permits table"
    # task :load_permissions => :environment do
    #   Dir.glob(File.join(Rails.root, "app", "screens", "*.rb")).map &method(:require) if Rails.env != 'production'
    #   
    #   WulinMaster::Screen.screens.each do |screen|
    #     screen_name = screen.name.sub(/Screen$/, "").underscore
    #     Permission.find_or_create_by_name("#{screen_name}#cud")
    #     Permission.find_or_create_by_name("#{screen_name}#read")
    #     print "."
    #   end
    #   puts ""
    # end
    
    desc "Load all screens and actions to permits table"
    task :load_permission => :environment do
      Rails.application.routes.routes.named_routes.values.map(&:defaults).each do |option|
        if option[:controller].present? and option[:action].present?
          controller_name = option[:controller].include?("/") ? option[:controller].split("/").last : option[:controller]
          controller_name = controller_name.singularize
          if %w(new show edit update create destroy wulin_master_new_form wulin_master_edit_form).include? option[:action]
            name = "#{controller_name}#cud"
          elsif option[:action] == 'index'
            name = "#{controller_name}#read"
          else
            name = "#{controller_name}##{option[:action]}"
          end
          Permission.find_or_create_by_name(name)
          print '.'
        end
      end
      puts ''
    end
    
  end
  
end