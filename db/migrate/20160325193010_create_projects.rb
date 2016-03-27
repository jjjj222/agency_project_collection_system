class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :status, :default => 'open'
      t.text :tags

      t.timestamps null: false
    end
  end
end
