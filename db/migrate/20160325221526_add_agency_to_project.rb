class AddAgencyToProject < ActiveRecord::Migration
  def change
    add_reference :projects, :agency, index: true, foreign_key: true
  end
end
