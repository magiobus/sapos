class CreateInternships < ActiveRecord::Migration
  def self.up
    create_table :internships do |t|
      t.references :internship_type
      t.string  "first_name",    :limit => 50, :null => false
      t.string  "last_name",     :limit => 50, :null => false
      t.string  "gender",        :limit => 1
      t.date    "date_of_birth"
      t.date    "start_date"
      t.date    "end_date"
      t.string  "location"
      t.string  "email"
      t.references :institution
      t.references :contact
      t.references :staff
      t.string  "thesis_title"
      t.text  "activities"
      t.string  "status",        :limit => 20, :default => 0
      t.string  "image"

      t.text    "notes"

      t.timestamps
    end
    add_index("internships", "institution_id")
    add_index("internships", "contact_id")
    add_index("internships", "internship_type_id")
    add_index("internships", "staff_id")

  end

  def self.down
    drop_table :internships
  end
end
