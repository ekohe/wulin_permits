class AddDescriptionToRoles < ActiveRecord::Migration[6.1]
  def change
    add_column(:roles, :description, :text) unless column_exists?(:roles, :description)
  end
end
