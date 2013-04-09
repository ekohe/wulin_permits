class CreateRolesUsers < ActiveRecord::Migration
  def up
    create_table :roles_users do |t|
      t.integer :user_id
      t.integer :role_id
      t.timestamps
    end unless table_exists?(:roles_users)
  end

  def down
    drop_table(:roles_users) if table_exists?(:roles_users)
  end
end
