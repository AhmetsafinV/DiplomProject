class AddFacultyToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :faculty, :string
  end
end
