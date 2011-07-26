class Course < ActiveRecord::Base
  belongs_to :program

  def full_name
    "#{code}: #{name}" rescue name
  end
end
