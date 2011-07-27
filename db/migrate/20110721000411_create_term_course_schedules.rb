class CreateTermCourseSchedules < ActiveRecord::Migration
  def self.up
    create_table :term_course_schedules do |t|
      t.references :term_course
      t.integer "day"
      t.time    "start_hour"
      t.time    "end_hour"
      t.references :classroom
      t.references :staff
      t.date    "start_date"
      t.date    "end_date"
      t.integer "class_type"
      t.integer "status",     :default => 1  
      t.timestamps
    end
    add_index("term_course_schedules", "term_course_id")
    add_index("term_course_schedules", "classroom_id")
    add_index("term_course_schedules", "staff_id")
  end

  def self.down
    drop_table :term_course_schedules
  end
end
