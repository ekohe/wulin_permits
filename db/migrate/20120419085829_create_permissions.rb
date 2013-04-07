class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name

      t.timestamps
    end unless table_exists?(:permissions)
    
    create_table :permissions_roles do |t|
      t.integer :permission_id
      t.integer :role_id
    end unless table_exists?(:permissions_roles)
    
  end
end
