class Role < ::ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true
  has_many :user_roles, foreign_key: 'role', dependent: :destroy
  has_many :permissions_roles, dependent: :destroy
  has_many :permissions, through: :permissions_roles
  
  # scope :available_roles, proc { |user_id| where('id NOT IN (?)', UserRole.where(user_id: user_id).pluck('role').uniq) }
  
  def self.available_roles(user_id)
    if (exclude_ids = UserRole.where(user_id: user_id).pluck('role').uniq).present?
      where('id NOT IN (?)', exclude_ids)
    else
      self
    end
  end
end