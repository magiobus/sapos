# coding: utf-8
class TermStudent < ActiveRecord::Base
  belongs_to :term
  belongs_to :student
  has_many :term_course_student

  ACTIVE   = 1
  PENDING  = 2
  INACTIVE = 3

  STATUS = {ACTIVE   => 'Activo',
            PENDING  => 'Con pendientes',
            INACTIVE => 'Baja'}

   def status_type
     STATUS[status]
   end
end
