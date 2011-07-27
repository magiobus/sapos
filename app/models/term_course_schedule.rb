class TermCourseSchedule < ActiveRecord::Base
  belongs_to :term_course
  belongs_to :staff
  belongs_to :classroom

  MONDAY    = 1
  TUESDAY   = 2
  WEDNESDAY = 3
  THURSDAY  = 4
  FRIDAY    = 5
  SATURDAY  = 6
  SUNDAY    = 7

  DAY = {MONDAY    => 'Lunes',
         TUESDAY   => 'Martes',
         WEDNESDAY => 'Miercoles',
         THURSDAY  => 'Jueves',
         FRIDAY    => 'Viernes',
         SATURDAY  => 'Sabado',
         SUNDAY    => 'Domingo'}

  def day_name
    DAY[day]
  end
end
