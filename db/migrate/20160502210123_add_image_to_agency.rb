class AddImageToAgency < ActiveRecord::Migration
  def change
    add_column :agencies, :image_url, :string
  end
end
