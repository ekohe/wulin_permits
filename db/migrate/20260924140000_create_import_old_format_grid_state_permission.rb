class CreateImportOldFormatGridStatePermission < ActiveRecord::Migration[6.1]
  def up
    Permission.find_or_create_by!(name: "grid_states#import_old_format")
  end

  def down
    Permission.find_by(name: "grid_states#import_old_format")&.destroy
  end
end
