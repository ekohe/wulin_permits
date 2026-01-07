class PermissionsPrivilege < ActiveRecord::Base
  belongs_to :permission
  belongs_to :privilege
  validates :privilege_id, uniqueness: {scope: :permission_id}
end
