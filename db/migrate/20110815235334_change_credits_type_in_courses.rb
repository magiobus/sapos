class ChangeCreditsTypeInCourses < ActiveRecord::Migration
  def self.up
    change_column :courses, :credits, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    change_column :courses, :credits, :integer
  end
end
