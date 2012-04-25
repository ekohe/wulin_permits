class UserRole < ::ActiveRecord::Base
  belongs_to :roler, foreign_key: 'role', class_name: 'Role'
  has_many :permissions, through: :role
  
  validates :user_id, :role, presence: true
  
  delegate :name, to: :roler, prefix: true, allow_nil: true
  
end