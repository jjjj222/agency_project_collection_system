class AddNetIdToTamuUsers < ActiveRecord::Migration
  def change
    add_column :tamu_users, :netid, :string
    add_column :tamu_users, :uin, :string
  end
end
