class CreateAdvances < ActiveRecord::Migration
  def self.up
    create_table :advances do |t|
      t.references :student
      t.text       "title"
      t.datetime   "advance_date"
      t.integer    "tutor1"
      t.integer    "tutor2"
      t.integer    "tutor3"
      t.integer    "tutor4"
      t.integer    "tutor5"
      t.string     "status", :limit => 1
      t.text       "notes"

      t.timestamps
    end
    add_index("advances", "student_id")
    add_index("advances", "tutor1")
    add_index("advances", "tutor2")
    add_index("advances", "tutor3")
    add_index("advances", "tutor4")
    add_index("advances", "tutor5")
  end

  def self.down
    drop_table :advances
  end
end
