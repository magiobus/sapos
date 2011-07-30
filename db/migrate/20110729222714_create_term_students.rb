class CreateTermStudents < ActiveRecord::Migration
  def self.up
    create_table :term_students do |t|
      t.references :term
      t.references :student
      t.string :notes
      t.integer "status",    :default => 1   
      t.timestamps
    end
    add_index("term_students", "term_id")
    add_index("term_students", "student_id")
  end

  def self.down
    drop_table :term_students
  end
end
