class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.references :program
      t.string  "code",      :limit => 10
      t.string  "name"
      t.integer "lecture_hours"
      t.integer "lab_hours"
      t.integer "credits"
      t.text    "description"
      t.integer "term",      :default => 1
      t.integer "prereq1"
      t.integer "prereq2"
      t.integer "prereq3"
      t.integer "coreq1"
      t.integer "coreq2"
      t.integer "coreq3"
      t.text    "notes"
      t.integer "status",    :default => 1  
      t.timestamps
    end
    add_index("courses", "program_id")
  end

  def self.down
    drop_table :courses
  end
end
