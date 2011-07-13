class CreateScholarships < ActiveRecord::Migration
  def self.up
    create_table :scholarships do |t|
      t.references :student
      t.string     "scholarship_type"
      t.date       "start_date"
      t.date       "end_date"
      t.string     "status"
      t.text       "notes"

      t.timestamps
    end
    add_index("scholarships", "student_id")
  end

  def self.down
    drop_table :scholarships
  end
end
