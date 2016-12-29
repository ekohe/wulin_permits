class RecreateWulinPermitsSchemaFromDb < ActiveRecord::Migration[5.0]
  def change
    create_table "roles_users", force: :cascade do |t|
      t.integer  "user_id"
      t.integer  "role_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "permissions", force: :cascade do |t|
      t.string   "name"
      t.datetime "created_at",              null: false
      t.datetime "updated_at",              null: false
      t.string   "description"
    end

    create_table "permissions_roles", force: :cascade do |t|
      t.integer "permission_id"
      t.integer "role_id"
    end

    create_table "roles", force: :cascade do |t|
      t.string   "name"
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end
  end
end
