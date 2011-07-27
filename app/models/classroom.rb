class Classroom < ActiveRecord::Base
  has_one :term_course_schedule
end
