class CreateGrades < ActiveRecord::Migration
  def change

    create_table :grades do |t|
      t.string :gradeletter, null:false
      t.timestamps null: false
    end

    add_reference :grades, :history, references: :histories, index: true
    add_foreign_key :grades, :histories, column: :history_id

  end
end
