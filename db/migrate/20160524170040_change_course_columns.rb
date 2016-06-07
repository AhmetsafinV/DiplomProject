class ChangeCourseColumns < ActiveRecord::Migration
  def change
    add_column :courses, :human_htype, :text
    remove_column :courses, :group_id
    remove_column :courses, :tutor_id
  end
end
