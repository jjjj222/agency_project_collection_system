class AddDescriptionToTamuUser < ActiveRecord::Migration
  def change
    add_column :tamu_users, :description, :text
  end
end
