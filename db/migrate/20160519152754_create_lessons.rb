class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :course_id
      t.text :typeL
      t.text :typeA
      t.date :date

      t.timestamps null: false
    end
  end
end
