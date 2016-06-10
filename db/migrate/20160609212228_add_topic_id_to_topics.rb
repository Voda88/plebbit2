class AddTopicIdToTopics < ActiveRecord::Migration
  def change
  	add_column :topics, :voteable_type, :string
  end
end
