class CreateTerms < ActiveRecord::Migration
  def self.up
    create_table :terms do |t|
      t.references :program
      t.string  "code",      :limit => 10
      t.string  "name",      :limit => 80
      t.date    "start_date"
      t.date    "end_date"
      t.integer "status",    :default => 1  
      t.timestamps
    end
    add_index("terms", "program_id")
  end

  def self.down
    drop_table :terms
  end
end
