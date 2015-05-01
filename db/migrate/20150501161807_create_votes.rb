class CreateVotes < ActiveRecord::Migration
  def change
  	create_table :votes do |table|
  		table.integer 	:restaurant_id , null: false
  		table.integer	:user_id, null: false
  		table.integer 	:event_id, null: false

  		table.timestamps 
  		
  	end
  end
end
