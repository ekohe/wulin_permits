class CreatePermissions < ActiveRecord::Migration
  def up
    create_table :permissions do |t|
      t.string :name
      t.string :description
      
      t.timestamps
    end unless table_exists?(:permissions)
    
    unless table_exists?(:permissions_roles)
      create_table :permissions_roles do |t|
        t.integer :permission_id
        t.integer :role_id
      end 
      add_index(:permissions_roles, [:permission_id, :role_id], :unique => true)
    end
    
  end

  def down
    drop_table(:permissions) if table_exists?(:permissions)
    drop_table(:permissions_roles) if table_exists?(:permissions_roles)
  end
end



