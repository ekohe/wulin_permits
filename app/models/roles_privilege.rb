class RolesPrivilege < ActiveRecord::Base
  belongs_to :role
  belongs_to :privilege
  validates :privilege_id, uniqueness: {scope: :role_id}
end
