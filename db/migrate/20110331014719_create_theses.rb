class CreateTheses < ActiveRecord::Migration
  def self.up
    create_table :theses do |t|
      t.references :student
      t.string     "number", :limit => 20
      t.integer    "consecutive"
      t.text       "title"
      t.text       "abstract"
      t.datetime   "defence_date"
      t.integer    "examiner1"
      t.integer    "examiner2"
      t.integer    "examiner3"
      t.integer    "examiner4"
      t.integer    "examiner5"
      t.string     "status", :limit => 1
      t.text       "notes" 

      t.timestamps
    end
    add_index("theses", "student_id")
    add_index("theses", "examiner1")
    add_index("theses", "examiner2")
    add_index("theses", "examiner3")
    add_index("theses", "examiner4")
    add_index("theses", "examiner5")
  end

  def self.down
    drop_table :theses
  end
end
