class CreateStances < ActiveRecord::Migration
  def self.up
    create_table :stances do |t|
      t.references :student
      t.references :institution
      t.date       "start_date"
      t.date       "end_date"
      t.string     "agreement"
      t.string     "status"
      t.text       "notes"
      t.timestamps
    end
    add_index("stances", "student_id")
    add_index("stances", "institution_id")
  end

  def self.down
    drop_table :stances
  end
end
