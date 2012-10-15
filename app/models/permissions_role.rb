class PermissionsRole < ActiveRecord::Base
  belongs_to :role
  belongs_to :permission
  attr_accessible :name, :description, :role_id, :permission_id

  def description
    self.permission.description
  end

  def description=(value)
    self.permission.update_attribute(:description, value)
  end
end