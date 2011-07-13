class CreateAcademicDegrees < ActiveRecord::Migration
  def self.up
    create_table :academic_degrees do |t|
      t.references :student
      t.string "year", :limit => 4
      t.string "name"
      t.references :institution
      t.text "notes"

      t.timestamps
    end
    add_index("academic_degrees", "student_id")
    add_index("academic_degrees", "institution_id")

  end

  def self.down
    drop_table :academic_degrees
  end
end
