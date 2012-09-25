class PermissionsRole < ActiveRecord::Base
  attr_accessible :name, :description
  belongs_to :role
  belongs_to :permission

  def description
    self.permission.description
  end

  def description=(value)
    self.permission.update_attribute(:description, value)
  end
end