class CreateCampus < ActiveRecord::Migration
  def self.up
    create_table :campus do |t|
      t.string  "short_name", :limit => 20
      t.string  "name"
      t.references :contact
      t.string  "image"
      t.timestamps
    end
  end

  def self.down
    drop_table :campus
  end
end
