class CreateEvents < ActiveRecord::Migration
  def change
  	create_table :events do |table|
  		table.string 	:description , null: false
  		table.timestamp :event_on , null: false
  		table.string 	:title , null: false
  		table.integer 	:group_id , null: false
  		table.string	:penalty

  		table.timestamps
  	end
  end
end
