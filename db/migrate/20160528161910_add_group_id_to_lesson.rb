class AddGroupIdToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :group_id, :integer
  end
end
