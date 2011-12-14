class CreateLabPractices < ActiveRecord::Migration
  def self.up
    create_table :lab_practices do |t|
      t.references :staff
      t.references :laboratory
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
    add_index("lab_practices", "staff_id")
    add_index("lab_practices", "institution_id")
    add_index("lab_practices", "laboratory_id")
  end

  def self.down
    drop_table :lab_practices
  end
end
