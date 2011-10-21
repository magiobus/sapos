class CreateInternshipFiles < ActiveRecord::Migration
  def self.up
    create_table :internship_files do |t|
      t.references :internship
      t.string  "description"
      t.string  "file"

      t.timestamps
    end
    add_index("internship_files", "internship_id")
  end

  def self.down
    drop_table :internship_files
  end
end
