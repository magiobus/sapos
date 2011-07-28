class TermCourse < ActiveRecord::Base
  belongs_to :term
  belongs_to :course

  has_many :term_course_schedule
  accepts_nested_attributes_for :term_course_schedule

  ASSIGNED   = 1
  UNASSIGNED = 2

end
