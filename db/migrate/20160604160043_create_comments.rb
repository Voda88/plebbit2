class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
		t.text :content
		t.string :title
		t.timestamps null: false
		t.integer :commentable_id
		t.integer  :user_id
		t.integer  :topic_id
    end
    add_index :comments, :commentable_id
  end
end
