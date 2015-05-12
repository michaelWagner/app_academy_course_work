class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id, null: false
      t.integer :author_id, null: false

      t.timestamps
    end
    add_index :comments, :commentable_id
    add_index :comments, :author_id
  end
end
