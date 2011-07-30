class CreateTermCourseStudents < ActiveRecord::Migration
  def self.up
    create_table :term_course_students do |t|
      t.references :term_course
      t.references :term_student
      t.integer "grade"
      t.integer "status", :default => 1  
      t.timestamps
    end
    add_index("term_course_students", "term_course_id")
    add_index("term_course_students", "term_student_id")
  end

  def self.down
    drop_table :term_course_students
  end
end
