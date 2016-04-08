class AddApprovedToAgency < ActiveRecord::Migration
  def change
    add_column :agencies, :approved, :boolean, :default => false
  end
end
