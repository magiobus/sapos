class TermStudent < ActiveRecord::Base
  belongs_to :term
  belongs_to :student

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
