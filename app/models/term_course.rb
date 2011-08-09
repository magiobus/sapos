# coding: utf-8
class TermCourse < ActiveRecord::Base
  belongs_to :term
  belongs_to :course

  has_many :term_course_schedules
  accepts_nested_attributes_for :term_course_schedules

  has_many :term_course_students
  accepts_nested_attributes_for :term_course_students

  ASSIGNED   = 1
  UNASSIGNED = 2
end
