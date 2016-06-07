class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.boolean :attendance
      t.integer :mark
      t.integer :student_id
      t.integer :lesson_id

      t.timestamps null: false
    end
  end
end
