class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.string :title
      t.timestamps null: false
    end
    add_index :comments, :commentable_id
  end
end
