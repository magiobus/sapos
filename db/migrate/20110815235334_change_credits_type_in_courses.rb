class ChangeCreditsTypeInCourses < ActiveRecord::Migration
  def self.up
    change_column :courses, :credits, :decimal, :precision => 8, :scale => 2
    change_column :courses, :lecture_hours, :decimal, :precision => 8, :scale => 2
    change_column :courses, :lab_hours, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    change_column :courses, :credits, :integer
    change_column :courses, :lecture_hours, :integer
    change_column :courses, :lab_hours, :integer
  end
end
