class AddScholarshipTypeIdToScholarships < ActiveRecord::Migration
  def self.up
    add_column :scholarships, :scholarship_type_id, :integer
    remove_column :scholarships, :scholarship_type
  end

  def self.down
    remove_column :scholarships, :scholarship_id
    add_column :scholarships, :scholarship_type
  end
end
