class CreateRestaurantTable < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string   :name, null: false
      t.string   :location, null: false
      t.integer  :business_id, null: false

      t.timestamps
    end
  end
end
