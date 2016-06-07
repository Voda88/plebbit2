class AddIndexToComments < ActiveRecord::Migration
  def change
    add_index :comments, [:commentable_id, :created_at]
  end
end
