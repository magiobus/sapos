class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.references :program
      t.string  "card",          :limit => 20
      t.string  "previous_card", :limit => 20
      t.integer "consecutive"
      t.string  "first_name",    :limit => 50, :null => false
      t.string  "last_name",     :limit => 50, :null => false
      t.string  "gender",        :limit => 1 
      t.date    "date_of_birth"
      t.string  "city"
      t.references  :state
      t.references  :country
      t.string  "email"
      t.integer "previous_institution"
      t.string  "previous_degree_type"
      t.string  "previous_degree_desc"
      t.date    "previous_degree_date"
      t.references :contact
      t.date    "start_date"
      t.date    "end_date"
      t.date    "graduation_date"
      t.date    "inactive_date"
      t.integer "supervisor"
      t.integer "co_supervisor"
      t.references  :department
      t.string  "curp"
      t.string  "ife"
      t.string  "cvu"
      t.string  "location" 
      t.string  "ssn"
      t.string  "blood_type"
      t.string  "accident_contact" 
      t.string  "accident_phone" 
      t.string  "passport" 
      t.string  "image" 
      t.integer "status",       :default => 1

      t.text    "notes" 

      t.timestamps
    end

    add_index("students", "card")
    add_index("students", "supervisor")
    add_index("students", "co_supervisor")
    add_index("students", "program_id")
    add_index("students", "contact_id")
    add_index("students", "country_id")
    add_index("students", "department_id")
  end

  def self.down
    drop_table :students
  end
end
