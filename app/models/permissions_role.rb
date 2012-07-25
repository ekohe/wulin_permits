class PermissionsRole < ActiveRecord::Base
  attr_accessible :name
  belongs_to :role
  belongs_to :permission
end