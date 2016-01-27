class CreateMessages < ActiveRecord::Migration
  def change

    create_table :messages do |t|
      t.timestamps null: false
    end

    add_reference :messages, :instructor, references: :users, index: true
    add_foreign_key :messages, :users, column: :instructor_id

    add_reference :messages, :student, references: :user, index: true
    add_foreign_key :messages, :users, column: :student_id

  end
end
