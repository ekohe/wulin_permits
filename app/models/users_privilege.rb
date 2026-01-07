class UsersPrivilege < ActiveRecord::Base
  belongs_to :privilege, optional: true
  belongs_to :user, optional: true

  validates :user_id, :privilege_id, presence: true
  validates_uniqueness_of :user_id, scope: %i[privilege_id]

  attr_accessor :email
end
