class CreatePrograms < ActiveRecord::Migration
  def self.up
    create_table :programs do |t|
      t.string "name"
      t.string "level", :limit => 20
      t.string "prefix", :limit => 5
      t.text   "description"
      t.timestamps
    end
  end

  def self.down
    drop_table :programs
  end
end
