class CreateGroupsTable < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer  :organizer_id, null: false
      t.integer  :admin_id, null: false
      t.string   :name, null: false

      t.timestamps
    end
  end
end
