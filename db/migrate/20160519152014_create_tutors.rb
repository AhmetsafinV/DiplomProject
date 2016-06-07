class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.text :first_name
      t.text :second_name
      t.text :last_name

      t.timestamps null: false
    end
  end
end
