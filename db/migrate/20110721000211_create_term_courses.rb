class CreateTermCourses < ActiveRecord::Migration
  def self.up
    create_table :term_courses do |t|
      t.references :term
      t.references :course
      t.integer "status",    :default => 1   
      t.timestamps
    end
    add_index("term_courses", "term_id")
    add_index("term_courses", "course_id")
  end

  def self.down
    drop_table :term_courses
  end
end
