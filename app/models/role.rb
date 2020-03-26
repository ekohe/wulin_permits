class Role < ::ActiveRecord::Base
  validates :name, presence: true
  has_many :roles_users, dependent: :destroy
  has_many :permissions_roles, dependent: :destroy
  has_many :permissions, through: :permissions_roles

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
