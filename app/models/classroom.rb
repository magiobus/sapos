class Classroom < ActiveRecord::Base
  has_one :term_course_schedule

  def full_name
    "#{code}: #{name}" rescue name
  end
end
