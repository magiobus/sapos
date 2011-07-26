class AddTermsDurationToPrograms < ActiveRecord::Migration
  def self.up
    add_column :programs, :terms_duration, :integer
  end

  def self.down
    remove_column :programs, :terms_duration
  end
end
