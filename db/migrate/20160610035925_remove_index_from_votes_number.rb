class RemoveIndexFromVotesNumber < ActiveRecord::Migration
  def change
  	remove_index :votes, :number
  end
end
