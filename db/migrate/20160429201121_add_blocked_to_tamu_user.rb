class AddBlockedToTamuUser < ActiveRecord::Migration
  def change
    add_column :tamu_users, :blocked, :boolean
  end
end
