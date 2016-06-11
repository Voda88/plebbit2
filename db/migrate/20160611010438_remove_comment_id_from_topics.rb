class RemoveCommentIdFromTopics < ActiveRecord::Migration
  def change
    remove_column :topics, :comment_id, :integer
  end
end
