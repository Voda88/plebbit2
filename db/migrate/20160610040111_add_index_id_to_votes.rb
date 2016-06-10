class AddIndexIdToVotes < ActiveRecord::Migration
  def change
  	add_index :votes, :id, unique:true
  end
end
