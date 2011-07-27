class CreateClassrooms < ActiveRecord::Migration
  def self.up
    create_table :classrooms do |t|
      t.string "code"
      t.string "name"
      t.integer "room_type"
      t.timestamps
    end
  end

  def self.down
    drop_table :classrooms
  end
end
