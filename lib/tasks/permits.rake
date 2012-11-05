if defined? WulinMaster
  namespace :wulin_permits do
    
    desc "Load all screens and actions to permits table"
    task :load_permission => :environment do
      # Import all screens
      Dir.glob(File.join(Rails.root, "app", "screens", "**", "*.rb")).map &method(:require)
      WulinMaster::Screen.screens.each do |screen|
        screen_name = screen.name.sub(/Screen$/, "").underscore
        Permission.find_or_create_by_name("#{screen_name}#cud")
        Permission.find_or_create_by_name("#{screen_name}#read")
        print "."
      end

      # Import all specific actions
      Rails.application.routes.routes.named_routes.values.map(&:defaults).each do |option|
        if option[:controller].present? and option[:action].present?
          controller_name = option[:controller].include?("/") ? option[:controller].split("/").last : option[:controller]
          controller_name = controller_name.singularize
          if %w(index new show edit update create destroy wulin_master_new_form wulin_master_edit_form).exclude? option[:action]
            #   name = "#{controller_name}#cud"
            # elsif option[:action] == 'index'
            #   name = "#{controller_name}#read"
            # else
            name = "#{controller_name}##{option[:action]}"
            Permission.find_or_create_by_name(name)
            print '.'
          end
        end
      end
      puts ''
    end
    
  end
end