class CreateSeminars < ActiveRecord::Migration
  def self.up
    create_table :seminars do |t|
      t.references :staff
      t.text       "title"
      t.string     "category"
      t.string     "location"
      t.datetime   "start_date"
      t.datetime   "end_date"
      t.text       "information"
      t.string     "status", :limit => 1
      t.timestamps
    end
    add_index("seminars", "staff_id")
  end

  def self.down
    drop_table :seminars
  end
end
