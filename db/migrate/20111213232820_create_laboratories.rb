class CreateLaboratories < ActiveRecord::Migration
  def self.up
    create_table :laboratories do |t|
      t.references :campus
      t.string "code"
      t.string "name"
      t.timestamps
    end
    add_index("laboratories", "campus_id")
  end

  def self.down
    drop_table :laboratories
  end
end
