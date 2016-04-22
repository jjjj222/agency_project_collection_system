class AddNetidToTamuUsers < ActiveRecord::Migration
  def change
    add_column :tamu_users, :netid, :string
  end
end
