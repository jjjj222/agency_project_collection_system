class AddMasterAdminToTamuUser < ActiveRecord::Migration
  def change
    add_column :tamu_users, :master_admin, :boolean, default: false
  end
end
