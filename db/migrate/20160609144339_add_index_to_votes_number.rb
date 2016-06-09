class AddIndexToVotesNumber < ActiveRecord::Migration
  def change
  	add_index :votes, :number, unique: true
  end
end
