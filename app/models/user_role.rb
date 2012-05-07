class UserRole < ::ActiveRecord::Base
  belongs_to :roler, foreign_key: 'role', class_name: 'Role'
  has_many :permissions, through: :role
  
  validates :user_id, :role, presence: true
  
  delegate :name, to: :roler, prefix: true, allow_nil: true
  
  def self.user_has_role?(user, role)
    where(user_id: user.id).pluck(:role).uniq.include?(role.id)
  end
  
end