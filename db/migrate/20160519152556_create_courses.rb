class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.text :name
      t.integer :tutor_id
      t.integer :group_id
      t.date :started_date
      t.date :finished_date
      t.time :started_time
      t.time :finished_time
      t.integer :period
      t.integer :wday
      t.text :room_name

      t.timestamps null: false
    end
  end
end
