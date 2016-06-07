class AddConnectTable < ActiveRecord::Migration
  def change
    create_table :courses_tutors, id: false do |t|
          t.belongs_to :course, index: true
          t.belongs_to :tutor, index: true
        end
        create_table :courses_groups, id: false do |t|
              t.belongs_to :course, index: true
              t.belongs_to :group, index: true
            end
  end
end
