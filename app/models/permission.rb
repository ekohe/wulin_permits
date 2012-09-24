class Permission < ActiveRecord::Base
  attr_accessible :name, :description
  
  has_many :permissions_roles, dependent: :destroy
  has_many :roles, through: :permissions_roles
  has_many :roles_users, through: :roles
end
