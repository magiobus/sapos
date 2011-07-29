class TermCourse < ActiveRecord::Base
  belongs_to :term
  belongs_to :course

  has_many :term_course_schedules
  accepts_nested_attributes_for :term_course_schedules

  ASSIGNED   = 1
  UNASSIGNED = 2

end
