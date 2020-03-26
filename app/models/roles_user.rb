class RolesUser < ::ActiveRecord::Base
  belongs_to :role
  belongs_to :user

  validates :user_id, :role, presence: true

  delegate :name, to: :roler, prefix: true, allow_nil: true

  def self.user_has_role?(user, role)
    return false if user.blank? or role.blank?
    where(user_id: user.id).pluck(:role_id).uniq.include?(role.id)
  end
end
