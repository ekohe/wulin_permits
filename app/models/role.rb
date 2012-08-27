class Role < ::ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true
  has_many :roles_users
  # has_many :users, through: :roles_users
  has_many :permissions_roles, dependent: :destroy
  has_many :permissions, through: :permissions_roles
  
  # scope :available_roles, proc { |user_id| where('id NOT IN (?)', RolesUser.where(user_id: user_id).pluck('role').uniq) }
  
  def users
    User.find(roles_users.pluck(:user_id))
  end
  
  def self.available_roles(user_id)
    if (exclude_ids = RolesUser.where(user_id: user_id).pluck('role_id').uniq).present?
      where('id NOT IN (?)', exclude_ids)
    else
      self
    end
  end
end