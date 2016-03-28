class AddRoleToTamuUser < ActiveRecord::Migration
  def change
    add_column :tamu_users, :role, :string
  end
end
