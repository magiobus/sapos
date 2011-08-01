class CreateScholarshipCategories < ActiveRecord::Migration
  def self.up
    create_table :scholarship_categories do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :scholarship_categories
  end
end
