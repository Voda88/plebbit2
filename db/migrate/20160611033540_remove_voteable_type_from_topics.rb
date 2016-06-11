class RemoveVoteableTypeFromTopics < ActiveRecord::Migration
  def change
    remove_column :topics, :voteable_type, :string
  end
end
