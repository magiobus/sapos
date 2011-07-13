class CreateStaffs < ActiveRecord::Migration
  def self.up
    create_table :staffs do |t|
      t.integer "employee_number"
      t.string  "title",         :limit => 10
      t.string  "first_name",    :limit => 50, :null => false
      t.string  "last_name",     :limit => 50, :null => false
      t.string  "gender",        :limit => 1
      t.date    "date_of_birth"
      t.string  "location"
      t.string  "email"
      t.references :institution
      t.references :contact
      t.string  "cvu"
      t.string  "sni",           :limit => 20
      t.string  "status",        :limit => 20, :default => 0
      t.string  "image"

      t.text    "notes"


      t.timestamps
    end
  end

  def self.down
    drop_table :staffs
  end
end
