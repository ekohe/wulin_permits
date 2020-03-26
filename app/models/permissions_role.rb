class PermissionsRole < ActiveRecord::Base
  belongs_to :role
  belongs_to :permission
  validates :permission_id, uniqueness: {scope: :role_id}

  def description
    self.permission.description
  end

  def description=(value)
    self.permission.update_attribute(:description, value)
  end
end
