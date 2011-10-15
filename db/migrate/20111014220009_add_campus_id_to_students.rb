class AddCampusIdToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :campus_id, :integer
    add_index("students", "campus_id")
  end

  def self.down
    remove_column :students, :campus_id
  end
end
