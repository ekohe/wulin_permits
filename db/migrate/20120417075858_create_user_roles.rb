class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.integer :user_id
      t.integer :role
      t.timestamps
    end unless table_exists?(:user_roles)
  end
end
