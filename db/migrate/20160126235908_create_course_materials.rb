class CreateCourseMaterials < ActiveRecord::Migration
  def change

    create_table :course_materials do |t|
      t.timestamps null: false
    end

    add_reference :course_materials, :course, references: :courses, index: true
    add_foreign_key :course_materials, :courses, column: :course_id

    add_reference :course_materials, :task, references: :tasks, index: true
    add_foreign_key :course_materials, :tasks, column: :task_id

  end
end
