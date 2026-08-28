# frozen_string_literal: true

class CreateUserManagementPermissions < ActiveRecord::Migration[6.1]
  def up
    WulinPermits::UserManagement::PERMISSIONS.each do |name|
      Permission.find_or_create_by!(name: name)
    end
  end

  def down
    Permission.where(name: WulinPermits::UserManagement::PERMISSIONS).delete_all
  end
end
