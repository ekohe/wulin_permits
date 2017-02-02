class RecreateWulinPermitsSchemaFromDb < ActiveRecord::Migration[5.0]
  def change
    create_table "roles_users" do |t|
      t.integer  "user_id"
      t.integer  "role_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end unless table_exists?(:roles_users)

    create_table "permissions" do |t|
      t.string   "name"
      t.datetime "created_at",              null: false
      t.datetime "updated_at",              null: false
      t.string   "description"
    end unless table_exists?(:permissions)

    create_table "permissions_roles" do |t|
      t.integer "permission_id"
      t.integer "role_id"
    end unless table_exists?(:permissions_roles)

    create_table "roles" do |t|
      t.string   "name"
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end unless table_exists?(:roles)
  end
end
