class AddMoreDetailsToScholarships < ActiveRecord::Migration
  def self.up
    add_column :scholarships, :amount, :string
    add_column :scholarships, :institution_id, :integer
    add_column :scholarships, :department_id, :integer
    add_column :scholarships, :other_department, :string
  end

  def self.down
    remove_column :scholarships, :amount
    remove_column :scholarships, :institution_id
    remove_column :scholarships, :department_id
    remove_column :scholarships, :other_department
  end
end
