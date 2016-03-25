class CreateJoinTableProjectTamuUsers < ActiveRecord::Migration
  def change
    create_join_table :projects, :tamu_users do |t|
      # t.index [:project_id, :tamu_user_id]
      # t.index [:tamu_user_id, :project_id]
    end
  end
end
