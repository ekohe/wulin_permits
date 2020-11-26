class RolesUser < ::ActiveRecord::Base
  belongs_to :role, optional: true
  belongs_to :user, optional: true

  validates :user_id, presence: true
  validates :role_id, presence: true

  delegate :name, to: :roler, prefix: true, allow_nil: true

  def self.user_has_role?(user, role)
    return false if user.blank? || role.blank?

    where(role_id: role.id, user_id: user.id).exists?
  end
end
