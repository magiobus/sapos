class AddTermsQtyToPrograms < ActiveRecord::Migration
  def self.up
    add_column :programs, :terms_qty, :integer
  end

  def self.down
    remove_column :programs, :terms_qty
  end
end
