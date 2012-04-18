class UserRole < ::ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :role
  validates_inclusion_of :role, :in => 0..(WulinPermits.roles.size - 1), :allow_blank => true, :allow_nil => true
  validates_uniqueness_of :role, :scope => [:user_id, :department_id]
  
  def human_role
    self.role.present? ? WulinPermits.roles[self.role] : nil
  end
end