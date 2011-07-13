class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      t.string  "name",         :limit => 100, :null => false
      t.string  "description"
      t.timestamps
    end
  end

  def self.down
    drop_table :departments
  end
end
