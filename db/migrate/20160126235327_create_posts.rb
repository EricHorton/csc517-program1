class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content, null:false
      t.timestamps null: false
    end
    add_reference :posts, :message, references: :messages, index: true
    add_foreign_key :posts, :messages, column: :message_id

  end
end
