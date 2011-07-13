class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  "email"
      t.integer "access",       :default => 2
      t.integer "status",       :default => 1
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
