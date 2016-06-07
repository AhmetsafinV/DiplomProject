class AddTime < ActiveRecord::Migration
  def change
    add_column :courses, :started_time, :integer
    add_column :courses, :finished_time, :integer
  end
end
