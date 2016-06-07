class ChangeTime < ActiveRecord::Migration
  def change
    remove_column :courses, :started_time
    remove_column :courses, :finished_time
  end
end
