class AddCommentIdToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :comment_id, :integer
  end
end
