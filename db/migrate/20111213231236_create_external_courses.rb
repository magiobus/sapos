class CreateExternalCourses < ActiveRecord::Migration
  def self.up
    create_table :external_courses do |t|
      t.references :staff
      t.references :institution
      t.text       "title"
      t.string     "location"
      t.datetime   "start_date"
      t.datetime   "end_date"
      t.string     "hours" 
      t.string     "participants" 
      t.text       "information"
      t.string     "status", :limit => 1
      t.timestamps
    end
    add_index("external_courses", "staff_id")
    add_index("external_courses", "institution_id")
  end

  def self.down
    drop_table :external_courses
  end
end
