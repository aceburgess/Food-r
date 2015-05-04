class AddWinnerToEvents < ActiveRecord::Migration
  def change
    add_column :events, :winner, :integer
  end
end
