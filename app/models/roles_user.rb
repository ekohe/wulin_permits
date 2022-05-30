class RolesUser < ::ActiveRecord::Base
  belongs_to :role, optional: true
  belongs_to :user, optional: true

  validates :user_id, :role_id, presence: true
  validates_uniqueness_of :user_id, scope: %i[role_id]

  attr_accessor :email

  def self.user_has_role?(user, role)
    return false if user.blank? || role.blank?

    where(role_id: role.id, user_id: user.id).exists?
  end
end
