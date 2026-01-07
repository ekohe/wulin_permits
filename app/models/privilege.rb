class Privilege < ActiveRecord::Base
  validates :name, presence: true
  has_many :roles_privileges, dependent: :destroy
  has_many :roles, through: :roles_privileges
  has_many :permissions_privileges, dependent: :destroy
  has_many :permissions, through: :permissions_privileges
  has_many :users_privileges, dependent: :destroy
  # has_many :users, through: :users_privileges
end
