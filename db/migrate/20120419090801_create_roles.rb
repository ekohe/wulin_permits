class CreateRoles < ActiveRecord::Migration
  def up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end unless table_exists?(:roles)
  end

  def down
    drop_table(:roles) if table_exists?(:roles)
  end
end
