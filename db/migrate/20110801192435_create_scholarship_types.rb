class CreateScholarshipTypes < ActiveRecord::Migration
  def self.up
    create_table :scholarship_types do |t|
      t.references :scholarship_category
      t.string :name
      t.string :description
      t.timestamps
    end
    add_index("scholarship_types", "scholarship_category_id")
  end

  def self.down
    drop_table :scholarship_types
  end
end
