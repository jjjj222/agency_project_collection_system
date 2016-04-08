class AddAdminToTamuUser < ActiveRecord::Migration
  def change
    add_column :tamu_users, :admin, :boolean, :default => false
  end
end
