class AddColumnsToAgency < ActiveRecord::Migration
  def change
    add_column :agencies, :provider, :string
    add_column :agencies, :uid, :string
    #add_column :agencies, :location, :string
    #add_column :agencies, :image_url, :string
    #add_column :agencies, :url, :string
  end
end
