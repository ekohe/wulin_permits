class UserAllPermission < ActiveRecord::Base
  self.primary_key = "id"
  self.table_name = "user_all_permissions"

  belongs_to :user, optional: true

  # This is a read-only view
  def readonly?
    true
  end

  # Virtual attribute for user email (will be populated by controller)
  attr_accessor :email
end
