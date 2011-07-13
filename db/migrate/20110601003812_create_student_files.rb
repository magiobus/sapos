class CreateStudentFiles < ActiveRecord::Migration
  def self.up
    create_table :student_files do |t|
      t.references :student
      t.string  "description"
      t.string  "file"

      t.timestamps
    end
    add_index("student_files", "student_id")
  end

  def self.down
    drop_table :student_files
  end
end
