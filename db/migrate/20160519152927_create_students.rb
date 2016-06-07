class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.text :first_name
      t.text :second_name
      t.text :last_name
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
