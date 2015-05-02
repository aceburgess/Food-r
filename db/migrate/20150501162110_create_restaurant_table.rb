class CreateRestaurantTable < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string   :name, null: false
      t.string   :location, null: false
      t.string   :business_id, null: false
      t.string   :picture_url, null: false
      t.string   :url, null: false
      t.string   :address, null: false
      t.string   :phone, null: false

      t.timestamps
    end
  end
end
